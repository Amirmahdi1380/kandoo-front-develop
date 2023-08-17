import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/projects/project_bloc.dart';
import '../../../bloc/projects/project_event.dart';
import '../../../bloc/projects/project_state.dart';
import '../../../widgets/container_builder_desktop_project.dart';


class GetProjectDesktopContainer extends StatefulWidget {
  const GetProjectDesktopContainer({super.key});

  @override
  State<GetProjectDesktopContainer> createState() => _GetProjectDesktopContainerState();
}

class _GetProjectDesktopContainerState extends State<GetProjectDesktopContainer> {
  @override
  void initState() {
    BlocProvider.of<ProjectBloc>(context).add(ProjectStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          //height: 300,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (state is ProjectLoadingState) ...{
                CircularProgressIndicator( )
              } else ...{
                if (state is ProjectResponseState) ...{
                  state.getProjects.fold(
                    (l) => Text(l),
                    (r) => PojectsContainerBuilderDesktop(r.projects),
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