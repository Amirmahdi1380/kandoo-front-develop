import 'package:dartz/dartz.dart';

abstract class RegisterState {}

class RegisterInitState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterResponseState extends RegisterState {
  Either<String, String> response;
  RegisterResponseState(this.response);
}
