import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Panorama extends StatefulWidget {
  const Panorama({super.key, required this.panoImages});

  final List<String> panoImages;

  @override
  State<Panorama> createState() => _PanoramaState();
}

class _PanoramaState extends State<Panorama> {
  final GlobalKey<PanoramaState> _panoramaKey = GlobalKey<PanoramaState>();

  int _panoId = 0;

  double zoomScale = 1;

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black38,
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
          onPressed: onPressed,
          child: Icon(icon),
        ),
        text != null
            ? Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  bool isZoomed = true;
  @override
  Widget build(BuildContext context) {
    _panoId = _panoId % widget.panoImages.length;
   
    return Scaffold(
      body: Stack(
        children: [
          PanoramaViewer(
              key: _panoramaKey,
              animSpeed: 1.0,
              minZoom: 0.6,
              maxZoom: 1.9,
              sensorControl: SensorControl.orientation,
              onImageLoad: () => LoadingAnimationWidget.inkDrop(
                  color: Colors.lightBlueAccent, size: 40),
              hotspots: [
                Hotspot(
                  latitude: -15.0,
                  longitude: -129.0,
                  width: 90,
                  height: 75,
                  widget: hotspotButton(
                    text: "Next Room",
                    icon: Icons.open_in_browser,
                    onPressed: () => setState(() => _panoId++),
                  ),
                ),
                Hotspot(
                  latitude: -42.0,
                  longitude: -46.0,
                  width: 60.0,
                  height: 60.0,
                  widget: hotspotButton(
                    icon: Icons.lens_rounded,
                    onPressed: () => setState(() =>
                        _panoId = Random().nextInt(widget.panoImages.length)),
                  ),
                ),
                Hotspot(
                  latitude: -33.0,
                  longitude: 123.0,
                  width: 60.0,
                  height: 60.0,
                  widget: hotspotButton(
                    icon: Icons.arrow_upward,
                    onPressed: () => setState(() {
                      _panoId = Random().nextInt(widget.panoImages.length);
                    }),
                  ),
                ),
              ],
              child: Image.network(
                  widget.panoImages[_panoId % widget.panoImages.length])),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Column(
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    highlightColor: Colors.amberAccent,
                    iconSize: 30,
                  ),
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () {
                    final currentState = _panoramaKey.currentState;
                    if (currentState != null) {
                      final currentZoom = currentState.scene!.camera.zoom;
                      currentState.setZoom(currentZoom + 0.3);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    highlightColor: Colors.amberAccent,
                    iconSize: 30,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.zoom_out),
                  onPressed: () {
                    final currentState = _panoramaKey.currentState;
                    if (currentState != null) {
                      final currentZoom = currentState.scene!.camera.zoom;
                      currentState.setZoom(currentZoom - 0.3);
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            right: 20.0,
            child: DropdownButton<int>(
              value: _panoId,
              padding: const EdgeInsets.all(8),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              dropdownColor: Colors.black38,
              iconEnabledColor: Colors.white,
              items: List.generate(
                widget.panoImages.length,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text('Room ${index + 1}',
                      style: textStyleNunito(
                          18,
                          Theme.of(context).colorScheme.primary,
                          FontWeight.w700,
                          0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _panoId = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
