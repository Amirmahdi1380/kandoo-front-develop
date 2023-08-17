import 'package:amlak_app/bloc/auth/check_login/login_event.dart';
import 'package:amlak_app/bloc/auth/check_login/login_state.dart';
import 'package:bloc/bloc.dart';

import '../../../data/respository/authentication_respository.dart';
import '../../../di/di.dart';
import '../register/register_event.dart';

class CheckLoginBloc extends Bloc<CheckLoginEvent, CheckLoginState> {
  final IAuthenticationRepository _authenticationRepository = locator.get();
  CheckLoginBloc() : super(CheckLoginStartState()) {
    on(
      (event, emit) async {
        if (event is CheckLoginInitEvent) {
          emit(CheckLoginStartState());
        } else if (event is CheckLoginButtonClick) {
          emit(CheckLoadingState());
          var response = await _authenticationRepository.login(
              event.mobileNumber,
              );
          emit(CheckLoginResponse(response));
        }
      },
    );
  }
}