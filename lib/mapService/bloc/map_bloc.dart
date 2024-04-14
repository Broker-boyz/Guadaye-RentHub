import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gojo_renthub/mapService/repositories/map_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as devtool show log;

part 'map_event.dart';
part 'map_state.dart';

MapRepo mapRepo = MapRepo();
Position? _position;

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<FetchMapData>((event, emit) {
      emit(MapLoading());
      try {
        _position = event.position;
        return emit(
            MapLoaded(currentPosition: event.position));
      } catch (e) {
        emit(const MapPermissionDenied(
            message:
                'Permission to access location is denied. You can enable it in your device settings.'));
      }
    });
    on<GoToAddis>((event, emit) {
      emit(MapLoading());
      mapRepo.updateCameraPosition(event.destination, event.mapController);
      emit(MapLoaded(currentPosition: _position!));
    });
    on<MapThemeLayoutSelected>(
      (event, emit) {
        emit(MapThemeSelected());
      },
    );
    on<MapStyleSelected>(
      (event, emit) {
        emit(MapStyleLoaded(selectedStyle: event.selectedStyle));
        emit(MapLoaded(currentPosition: _position!));
      },
    );
  }
  @override
  void onChange(Change<MapState> change) {
    super.onChange(change);
    devtool.log('Change =>$change');
  }

  @override
  void onTransition(Transition<MapEvent, MapState> transition) {
    super.onTransition(transition);
    devtool.log("Transition =>$transition");
  }
}
