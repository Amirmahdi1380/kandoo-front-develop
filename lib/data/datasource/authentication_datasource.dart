import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utils/apiExeption.dart';
import '../model/users/Check.dart';

abstract class IAuthenthicationDatasource {
  Future<void> register(String first_name, String last_name,
      String national_code, String mobile, String birthday);
  Future<void> login(String mobile);
  Future<String> getcheckOtp(String mobileNumber, String sms);
}

class AuthenthicationDatasource extends IAuthenthicationDatasource {
  final Dio _dio = locator.get();
  Future<void> register(String first_name, String last_name,
      String national_code, String mobile, String birthday) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'national_code': national_code,
          'mobile': mobile,
          'birthday': birthday,
        },
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<void> login(String mobile) async {
    try {
      var result = await _dio.post('/auth/login-otp', data: {'mobile': mobile});
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<String> getcheckOtp(String mobileNumber, String sms) async {
    try {
      var response = await _dio.post('/auth/check-otp', data: {
        'mobile': mobileNumber,
        'token': sms
      }); // Make the API request
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        // Retrieve the JSON data from the response
        return response.data?['token'];
        // return Ckeck.fromJson(jsonData); // Map the JSON data to your model
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }
}
