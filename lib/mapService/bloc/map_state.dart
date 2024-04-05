part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapPermissionDenied extends MapState {
  const MapPermissionDenied({
    required this.message,
  });

  final String message;
  @override
  List<Object> get props => [message];
}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final Position currentPosition;

  final List<MarkerData> points;

  const MapLoaded({
    required this.currentPosition,
    required this.points,
  });

  @override
  List<Object> get props => [
        currentPosition,
        points,
      ];
}

final class CameraMove extends MapState {}

final class UserLocationUpdate extends MapState {}

final class MapThemeSelected extends MapState {}

final class MapStyleLoaded extends MapState {
  const MapStyleLoaded({
    required this.selectedStyle,
  });

  final int selectedStyle;
  @override
  List<Object> get props => [selectedStyle];
}


//   List<Object> get props => [cameraPosition, currentLocationIcon, points];
// }