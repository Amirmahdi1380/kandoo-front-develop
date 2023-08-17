import 'package:amlak_app/bloc/projects/project_event.dart';
import 'package:amlak_app/bloc/projects/project_state.dart';
import 'package:amlak_app/data/respository/project_repository.dart';
import 'package:amlak_app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final IProjectsRepository _iProjectsRepository = locator.get();
  ProjectBloc() : super(ProjectInitState()) {
    on((event, emit) async {
      if (event is ProjectStartEvent) {
        emit(ProjectLoadingState());
        var getProjet = await _iProjectsRepository.getProjects();
        emit(ProjectResponseState(getProjet));
      }
    });
  }
}
