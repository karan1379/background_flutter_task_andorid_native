import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class LocationPage extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker')),
      body: Center(
        child: Obx(() {
          final loc = controller.currentLocationData.value;
          if (loc == null) return const Text("Fetching location...");
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Latitude: ${loc.latitude}"),
              Text("Longitude: ${loc.longitude}"),
            ],
          );
        }),
      ),
    );
  }
}
