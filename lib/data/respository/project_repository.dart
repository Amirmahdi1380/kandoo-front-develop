import 'package:amlak_app/data/datasource/projects_datasource.dart';
import 'package:amlak_app/data/model/projects/projects.dart';
import 'package:amlak_app/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../utils/apiExeption.dart';
import '../model/projects/Root.dart';

abstract class IProjectsRepository {
  Future<Either<String , Root>> getProjects();
}


class ProjectsRepository extends IProjectsRepository{
  @override
  final IProjectsDatasource _projectsDatasource= locator.get();
  Future<Either<String, Root>> getProjects() async{
    try {
      var response = await _projectsDatasource.getProjects();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}