part of 'property_bloc.dart';

abstract class PropertyState extends Equatable {
  const PropertyState();
  
  @override
  List<Object> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<MyProperty> properties;

  const PropertyLoaded({required this.properties});

  @override
  List<Object> get props => [properties];
}

class PropertyAddedState extends PropertyState {}

class PropertyApprovedState extends PropertyState {}

class PropertyRejectedState extends PropertyState {}

class PropertyError extends PropertyState {
  final String errorMessage;

  const PropertyError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
