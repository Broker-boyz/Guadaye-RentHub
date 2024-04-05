import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gojo_renthub/mapService/bloc/map_bloc.dart';
import 'package:gojo_renthub/mapService/repositories/map_repo.dart';
import 'package:gojo_renthub/mapService/screen/map_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MapPermissionPage extends StatelessWidget {
  const MapPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MapRepo mapRepo = MapRepo();
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    return FutureBuilder<Position>(
      future: mapRepo.requestPermission(geolocatorPlatform),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocProvider<MapBloc>(
            create: (context) => MapBloc()
              ..add(FetchMapData(position: snapshot.data!, points: const [])),
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: GoogleMapScreen(),
              
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.lightBlueAccent, size: 50)),
            ),
          );
        }
      },
    );
  }
}
