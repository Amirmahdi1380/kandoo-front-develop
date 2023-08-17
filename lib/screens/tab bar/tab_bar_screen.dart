import 'package:amlak_app/bloc/auth/register/register_bloc.dart';
import 'package:amlak_app/bloc/projects/project_bloc.dart';
import 'package:amlak_app/bloc/projects/project_event.dart';
import 'package:amlak_app/bloc/projects/project_state.dart';
import 'package:amlak_app/section/sign_up/sign_up_mobile_scree.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/container_builder_mobile_projects.dart';
import '../../section/login/login_mobile_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  void initState() {
    BlocProvider.of<ProjectBloc>(context).add(ProjectStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
        return SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: SvgPicture.asset(
                    'assets/images/login_img.svg',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ButtonsTabBar(
                    height: 50,
                    //center: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    // Customize the appearance and behavior of the tab bar
                    backgroundColor: Colors.blue,
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SM',
                        fontSize: 18),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: 'SM',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // Add your tabs here
                    tabs: const [
                      Tab(
                        text: 'ورود',
                      ),
                      Tab(
                        text: 'ثبت نام',
                      )
                    ]),
                SizedBox(
                  height: 140,
                  child: TabBarView(
                    children: [
                      LoginScreen(),
                      BlocProvider(
                        create: (context) => RegisterBloc(),
                        child: SignInScreen(),
                      )
                    ],
                  ),
                ),
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
          ),
        );
      }),
    );
  }
}
