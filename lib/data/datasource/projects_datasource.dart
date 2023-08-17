import 'package:amlak_app/data/model/projects/projects.dart';
import 'package:amlak_app/di/di.dart';
import 'package:dio/dio.dart';

import '../model/projects/Root.dart';

abstract class IProjectsDatasource {
  Future<Root> getProjects();
}

class ProjectsDtasource extends IProjectsDatasource {
  final Dio _dio=locator.get();
  @override
  Future<Root> getProjects() async{
     Response response = await _dio.get(
      '/projects',
    );
    if (response.statusCode == 200) {
      return Root.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}