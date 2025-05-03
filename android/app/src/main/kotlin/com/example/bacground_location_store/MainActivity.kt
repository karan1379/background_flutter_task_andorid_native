package com.example.bacground_location_store

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.locationChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "startLocationService" -> {
                    val intent = Intent(this, LocationService::class.java)
                    startForegroundService(intent)
                    result.success(null)
                }
                "getLastLocation" -> {
                    val dbHelper = LocationDatabaseHelper(this)
                    val location = dbHelper.getLastLocation()
                    if (location != null) {
                        result.success(mapOf(
                            "latitude" to location.latitude,
                            "longitude" to location.longitude
                        ))
                    } else {
                        result.success(null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
