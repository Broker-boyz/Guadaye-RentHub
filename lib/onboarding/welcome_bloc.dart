import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_renthub/onboarding/welcome_event.dart';
import 'package:gojo_renthub/onboarding/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<WelcomeEvent>(
      (event, emit) {
        emit(WelcomeState(page: state.page + 1));
      },
    );
  }
}

// class WelcomeState {
//   int page;

//   WelcomeState({this.page = 0});
// }

// class WelcomeEvent {}

