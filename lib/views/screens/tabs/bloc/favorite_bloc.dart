import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev show log;

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteUpdate>((event, emit) {
      emit(FavoriteLoading());
      dev.log('In FAvorite bloc');
      emit(FavoriteChanges(isFavorite: event.isFavorite));
    });
  }
  @override
  void onTransition(Transition<FavoriteEvent, FavoriteState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
