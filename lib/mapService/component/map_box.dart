import 'package:flutter/material.dart';
import 'package:gojo_renthub/mapService/component/marker_icon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBox extends StatelessWidget {
  const MapBox({super.key, required this.customMarker, required this.latLng});

  final BitmapDescriptor customMarker;
  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    GoogleMapController? controller;
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(5.0, 5.0),
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: GoogleMap(
        padding: const EdgeInsets.only(top: 30),
        initialCameraPosition: CameraPosition(target: latLng, zoom: 8),
        onTap: (position) {
          controller!.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(target: latLng)));
        },
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        mapToolbarEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId('id'),
              position: const LatLng(9.0182, 38.7525),
              icon: customMarker,
              infoWindow:
                  const InfoWindow(title: 'Address is given after booking'))
        },
      ),
    );
  }
}
