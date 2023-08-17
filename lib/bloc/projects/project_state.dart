import 'package:amlak_app/data/model/projects/projects.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/projects/Root.dart';

abstract class ProjectState {}

class ProjectInitState extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectResponseState extends ProjectState {
  Either<String , Root> getProjects;
  ProjectResponseState(this.getProjects);
}