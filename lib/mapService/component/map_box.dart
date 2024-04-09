import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBox extends StatefulWidget {
  const MapBox({super.key, required this.ccustomMarker, required this.latLng});

  final BitmapDescriptor ccustomMarker;
  final LatLng latLng;

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    _getIcon();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getIcon() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              bundle: DefaultAssetBundle.of(
                context,
              ),
            ),
            'assets/images/home-marker.png')
        .then(
      (icon) {
        customMarker = icon;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController? controller;
  
    return Column(
      children: [
        Container(
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
            initialCameraPosition:
                CameraPosition(target: widget.latLng, zoom: 12),
            onTap: (position) {
              controller!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: widget.latLng)));
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
        ),
      ],
    );
  }
}
