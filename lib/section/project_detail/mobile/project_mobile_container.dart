import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/projects/project_bloc.dart';
import '../../../bloc/projects/project_event.dart';
import '../../../bloc/projects/project_state.dart';
import '../../../widgets/container_builder_mobile_projects.dart';

class GetProjectMobileContainer extends StatefulWidget {
  const GetProjectMobileContainer({super.key});

  @override
  State<GetProjectMobileContainer> createState() => _GetProjectMobileContainerState();
}

class _GetProjectMobileContainerState extends State<GetProjectMobileContainer> {
  @override
  void initState() {
    BlocProvider.of<ProjectBloc>(context).add(ProjectStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return SizedBox(
          child: Column(
            children: [
              if (state is ProjectLoadingState) ...{
                CircularProgressIndicator()
              } else ...{
                if (state is ProjectResponseState) ...{
                  state.getProjects.fold(
                    (l) => Text(l),
                    (r) => PojectsContainerBuilderMobile(r.projects),
                  )
                }
              }
            ],
          ),
        );
      },
    );
  }
}