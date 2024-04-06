part of 'property_bloc.dart';

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

class AddPropertyEvent extends PropertyEvent {
  final MyProperty property;
  final String userId;
  final List<File> images;

  const AddPropertyEvent({
    required this.property,
    required this.userId,
    required this.images,
  });

  @override
  List<Object> get props => [property, userId, images];
}

class LoadPropertyEvent extends PropertyEvent {}

class ApprovePropertyEvent extends PropertyEvent {
  final MyProperty property;

  const ApprovePropertyEvent({required this.property});

  @override
  List<Object> get props => [property];

}
class RejectPropertyEvent extends PropertyEvent {
  final MyProperty property;

  const RejectPropertyEvent({required this.property});

  @override
  List<Object> get props => [property];

}
