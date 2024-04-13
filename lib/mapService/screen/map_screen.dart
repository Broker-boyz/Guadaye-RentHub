// ignore_for_file: library_private_types_in_public_api, unused_import, must_be_immutable

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/mapService/bloc/map_bloc.dart';
import 'package:gojo_renthub/mapService/component/lower_button1.dart';
import 'package:gojo_renthub/mapService/component/marker_icon.dart';
import 'package:gojo_renthub/mapService/component/select_themes_bottom_sheet.dart';
import 'package:gojo_renthub/mapService/mapthemes/map_theme.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/shared/fonts/nunito.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as devtool show log;

import 'package:loading_animation_widget/loading_animation_widget.dart';

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({super.key, required this.property});
  List<MyProperty> property;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  late final List<MarkerData> _customMarkers = [];
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Position? position;

  final List<dynamic> _mapThemes = MapTheme.mapThemes;
  int _selectedMapThemes = 0;
  List<MyProperty> myProperty = [];
  @override
  void initState() {
    myProperty = widget.property;
    print(myProperty);
    markerCreator();
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  void markerCreator() {
    for (var i = 0; i < myProperty.length; i++) {
      _customMarkers.add(MarkerData(
          marker: Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(myProperty[i].latitude, myProperty[i].longitude),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                    myProperty[i].imageUrl[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            myProperty[i].title,
                            style: textStyleNunito(
                                18,
                                Theme.of(context).colorScheme.inversePrimary,
                                FontWeight.w900,
                                0),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(myProperty[i].description,
                              style: textStyleNunito(
                                  16,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FontWeight.w900,
                                  0)),
                          const SizedBox(
                            height: 8,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Get.to(() => PropertyDetailPage(
                                    myProperty: myProperty[i],
                                  ));
                            },
                            elevation: 0,
                            height: 40,
                            minWidth: double.infinity,
                            color: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text(
                              "See details",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      left: 5.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                      ),
                    ),
                  ],
                ),
                LatLng(myProperty[i].latitude, myProperty[i].longitude),
              );
            },
          ),
          child: customMarker(myProperty[i].price.toString())));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapThemeSelected) {
            selectThemeBottomSheet(
              context: context,
              mapThemes: _mapThemes,
            );
          }
          if (state is MapStyleLoaded) {
            _selectedMapThemes = state.selectedStyle;
          }
        },
        builder: (context, state) {
          if (state is MapLoaded) {
            position = state.currentPosition;
            return Stack(
              children: [
                CustomGoogleMapMarkerBuilder(
                  customMarkers: _customMarkers,
                  builder: (context, markers) {
                    if (markers == null) {
                      return Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                              color: Colors.lightBlueAccent, size: 50));
                    }

                    return GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      padding: const EdgeInsets.only(top: 300),
                      style: _mapThemes[_selectedMapThemes]['style'],
                      initialCameraPosition: CameraPosition(
                          zoom: 12,
                          target: LatLng(state.currentPosition.latitude,
                              state.currentPosition.longitude)),
                      markers: markers,
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                    );
                  },
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  offset: 60.0,
                ),
                LowerButton1(controller: _controller),
                Positioned(
                  bottom: 160,
                  right: 15,
                  child: Container(
                      width: 35,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              context
                                  .read<MapBloc>()
                                  .add(MapThemeLayoutSelected());
                            },
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.layers_rounded, size: 25),
                          )
                        ],
                      )),
                )
              ],
            );
          } else {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.lightBlueAccent, size: 50));
          }
        },
      ),
    );
  }
}
