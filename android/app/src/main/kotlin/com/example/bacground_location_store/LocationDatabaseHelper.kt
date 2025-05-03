package com.example.bacground_location_store

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

class LocationDatabaseHelper(context: Context) : SQLiteOpenHelper(context, "location.db", null, 1) {

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL("CREATE TABLE location(id INTEGER PRIMARY KEY AUTOINCREMENT, latitude REAL, longitude REAL)")
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.execSQL("DROP TABLE IF EXISTS location")
        onCreate(db)
    }

    fun insertLocation(lat: Double, lng: Double) {
        val values = ContentValues().apply {
            put("latitude", lat)
            put("longitude", lng)
        }
        writableDatabase.insert("location", null, values)
    }

    fun getLastLocation(): LocationModel? {
        val db = readableDatabase
        val cursor = db.rawQuery("SELECT * FROM location ORDER BY id DESC LIMIT 1", null)
        return if (cursor.moveToFirst()) {
            val lat = cursor.getDouble(cursor.getColumnIndexOrThrow("latitude"))
            val lng = cursor.getDouble(cursor.getColumnIndexOrThrow("longitude"))
            cursor.close()
            LocationModel(lat, lng)
        } else {
            cursor.close()
            null
        }
    }
} 