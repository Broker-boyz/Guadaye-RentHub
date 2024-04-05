import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBox extends StatelessWidget {
  const MapBox({
    super.key,
    required this.customMarker,
  });

  final BitmapDescriptor customMarker;

  @override
  Widget build(BuildContext context) {
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
        initialCameraPosition:
            const CameraPosition(target: LatLng(9.0182, 38.7525), zoom: 14),
        onTap: null,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        mapToolbarEnabled: false,
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
