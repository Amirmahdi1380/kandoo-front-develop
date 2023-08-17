import 'package:dartz/dartz.dart';

import '../../../data/model/users/Check.dart';

abstract class CheckLoginState {}

class CheckLoginStartState extends CheckLoginState{}

class CheckLoadingState extends CheckLoginState{}

class CheckLoginResponse extends CheckLoginState {
  Either<String , String> getCheck;
  CheckLoginResponse(this.getCheck);
}