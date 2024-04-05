part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

final class GoToAddis extends MapEvent {
  final LatLng destination;
  final Completer<GoogleMapController> mapController;
  final List<LatLng> points;

  const GoToAddis(
      {required this.destination,
      required this.mapController,
      required this.points});
  @override
  List<Object> get props => [destination, mapController, points];
}

final class FetchMapData extends MapEvent {
  const FetchMapData({required this.position, required this.points});

  final Position position;
  final List<LatLng> points;
  @override
  List<Object> get props => [position, points];
}

final class MapThemeLayoutSelected extends MapEvent {
}

final class MapStyleSelected extends MapEvent {
  final int selectedStyle;
  const MapStyleSelected({required this.selectedStyle});
  @override
  List<Object> get props => [selectedStyle];
}
