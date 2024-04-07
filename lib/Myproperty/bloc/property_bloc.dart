import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final MyPropertyRepo repo;
  PropertyBloc({required this.repo}) : super(PropertyInitial()) {
    on<AddPropertyEvent>((event, emit) async{
      emit(PropertyLoading());
      try {
        await repo.addProperty(property: event.property, images: event.images, userId: event.userId);
        final result = await repo.loadMyProperties(event.property.category);
        emit(PropertyLoaded(properties: result));
      } catch (e) {
        emit(PropertyError(errorMessage: 'Error has occurred while uplaoding new property $e'));
      }
    });
    on<LoadPropertyEvent>((event, emit) async{
      emit(PropertyLoading());
      try {
        final properties =  await repo.loadMyProperties('');
        emit(PropertyLoaded(properties: properties));
      } catch (e) {
        emit(PropertyError(errorMessage: 'Error has occurred while uploading new property $e'));
      }
    });
    on<ApprovePropertyEvent>((event, emit) async{
      emit(PropertyLoading());
      try {
        await repo.approveProperty(property: event.property);
        final result = await repo.loadMyProperties('');
        emit(PropertyLoaded(properties: result));
      } catch (e) {
        emit(PropertyError(errorMessage: 'Error has occurred while approving a property $e'));
      }
    });
    on<RejectPropertyEvent>((event, emit) async{
      emit(PropertyLoading());
      try {
        await repo.rejectProperty(property: event.property);
        final result = await repo.loadMyProperties('');
        emit(PropertyLoaded(properties: result));
      } catch (e) {
        emit(PropertyError(errorMessage: 'Error has occurred while rejecting a property $e'));
      }
    });

  }
}
