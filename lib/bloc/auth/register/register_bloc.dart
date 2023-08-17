import 'package:amlak_app/bloc/auth/register/register_event.dart';
import 'package:amlak_app/data/respository/authentication_respository.dart';
import 'package:amlak_app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:amlak_app/bloc/auth/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IAuthenticationRepository _authenticationRepository = locator.get();
  RegisterBloc() : super(RegisterInitState()) {
    on(
      (event, emit) async {
        if (event is RegisterStartEvent) {
          emit(RegisterInitState());
        } else if (event is RegisterRequestEvent) {
          emit(RegisterLoadingState());
          var response = await _authenticationRepository.register(
              event.first_name,
              event.last_name,
              event.national_code,
              event.mobile,
              event.birthday);
          emit(RegisterResponseState(response));
        }
      },
    );
  }
}
