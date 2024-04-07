import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LowerButton1 extends StatelessWidget {
  const LowerButton1({
    super.key,
    required GoogleMapController? controller,
  }) : _controller = controller;

  final GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 15,
      child: Container(
          width: 35,
          height: 105,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  _controller?.animateCamera(CameraUpdate.zoomIn());
                },
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add, size: 25),
              ),
              const Divider(height: 5),
              MaterialButton(
                onPressed: () {
                  _controller?.animateCamera(CameraUpdate.zoomOut());
                },
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.remove, size: 25),
              )
            ],
          )),
    );
  }
}
