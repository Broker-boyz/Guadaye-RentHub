import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as devtool show log;

class MapRepo{
  
   void updateCameraPosition(LatLng targetLatLng,Completer<GoogleMapController> mapController) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: targetLatLng,
        zoom: 15.0,
      ),
    ));
  }

  Future<Position> requestPermission(GeolocatorPlatform geolocator) async {
  bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) {
    return Future.error(
        "Location services are disabled. Please enable them in your device settings.");
  }

  LocationPermission permission = await geolocator.checkPermission();

  switch (permission) {
    case LocationPermission.whileInUse:
    case LocationPermission.always:
      devtool.log("Finding position...");
      return await geolocator.getCurrentPosition();
    case LocationPermission.denied:
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            "Permission to access location is denied. You can enable it in your device settings.");
      }

      devtool.log("Finding position...");
      return await geolocator.getCurrentPosition();
    case LocationPermission.deniedForever:
      return Future.error(
          "Location permission is permanently denied. To enable it, go to your device settings and grant location permission to this app.");
    default:
      return Future.error("Unexpected permission status: $permission");
  }
}

}