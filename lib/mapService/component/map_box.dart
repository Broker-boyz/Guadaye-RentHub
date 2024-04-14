import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gojo_renthub/mapService/mapthemes/map_theme.dart';
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
  final Completer<GoogleMapController> _controller = Completer();

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
            'assets/images/home_marker.png')
        .then(
      (icon) {
        customMarker = icon;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
       
        Container(
          height: MediaQuery.of(context).size.height / 2,
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
            style: MapTheme.mapThemes[2]['style'],
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            initialCameraPosition:
                CameraPosition(target: widget.latLng, zoom: 15),
            onTap: (position) async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: widget.latLng,
                  zoom: 15.0,
                ),
              ));
             
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            mapToolbarEnabled: true,
            markers: {
              Marker(
                  markerId: MarkerId('${widget.latLng}'),
                  position: widget.latLng,
                  icon: customMarker,
                  infoWindow:
                      const InfoWindow(
                      snippet:
                          'You can send rent request by pressing rent now button',
                      title:
                          'Contact detail is given after sending rent request')),
            },
          ),
        ),
      ],
    );
  }
}
