import 'package:bacground_location_store/location_model.dart';
import 'package:get/get.dart';
import 'method_channel_class.dart';

class LocationController extends GetxController {
  Rxn<LocationModel?> currentLocationData = Rxn();
  RxBool isServiceRunning = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  late MethodChannelClass methodChannelClass;

  @override
  void onInit() {
    methodChannelClass = MethodChannelClass();
    super.onInit();
    fetchInitialLocation();
    startService();
  }

  void fetchInitialLocation() async {
    var data = await methodChannelClass.getLastLocation();
    if (data != null) {
      currentLocationData.value = LocationModel(
        latitude: data['latitude'],
        longitude: data['longitude'],
      );
    }
  }

  void startService() {
    MethodChannelClass.startLocationService();
    isServiceRunning.value = true;
  }

  Future<bool> stopService() async {
    try {
      errorMessage.value = '';
      final success = await MethodChannelClass.stopLocationService();
      isServiceRunning.value = !success;
      return success;
    } catch (e) {
      errorMessage.value = 'Error stopping service: $e';
      return false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }
}
