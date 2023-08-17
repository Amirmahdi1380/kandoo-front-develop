import 'package:amlak_app/data/model/users/Check.dart';
import 'package:amlak_app/utils/auth_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/di.dart';
import '../../utils/apiExeption.dart';
import '../datasource/authentication_datasource.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(String first_name, String last_name,
      String national_code, String mobile, String birthday);
      Future<Either<String , String>> login(String mobileNumber);
      Future<Either<String , String>> getcheckOtp(String mobileNumber,String sms);
}

class AuthenticationRemote extends IAuthenticationRepository {
  final IAuthenthicationDatasource _datasource = locator.get();
  final SharedPreferences _sharedPreferences = locator.get();
  Future<Either<String, String>> register(String first_name, String last_name,
      String national_code, String mobile, String birthday) async {
    try {
      var res = await _datasource.register(
        first_name,
        last_name,
        national_code,
        mobile,
        birthday,
      );

      return right('ثبت نام انجام شد !');
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }
  
  @override
  Future<Either<String, String>> getcheckOtp(String mobileNumber , String sms) async{
 try {
      var token = await _datasource.getcheckOtp(
        mobileNumber
        ,sms
      );
      if (token.isNotEmpty) {
        AuthMnager.saveToken(token);
        return right('.با موفقیت وارد شده اید');
      }else {
        return left('خطایی در ورود پیش آمده است');
      }
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }
  
  @override
  Future<Either<String, String>> login(String mobileNumber) async{
   try {
      var res = await _datasource.login(
        mobileNumber
      );

      return right('ثبت نام انجام شد !');
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }
}
