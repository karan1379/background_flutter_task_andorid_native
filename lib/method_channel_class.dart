import 'package:flutter/services.dart';

class MethodChannelClass {
  static const platform = MethodChannel('com.example.locationChannel');

  Future<Map<String, dynamic>?> getLastLocation() async {
    try {
      final result = await platform.invokeMethod('getLastLocation');
      return Map<String, dynamic>.from(result);
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  static Future startLocationService() async {
    try {
      await platform.invokeMethod('startLocationService');
    } catch (e) {
      print('Error starting service: $e');
    }
  }

  static Future<bool> stopLocationService() async {
    try {
      await platform.invokeMethod('stopLocationService');
      return true;
    } on PlatformException catch (e) {
      print('Platform error while stopping service: ${e.message}');
      return false;
    } catch (e) {
      print('Error stopping location service: $e');
      return false;
    }
  }
}
