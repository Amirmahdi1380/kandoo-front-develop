import 'dart:ui';

import 'package:amlak_app/bloc/projects/project_bloc.dart';
import 'package:amlak_app/responsive/responsive.dart';
import 'package:amlak_app/screens/Home_screen.dart';
import 'package:amlak_app/section/login/login_desktop_screen.dart';
import 'package:amlak_app/section/login/login_mobile_screen.dart';
import 'package:amlak_app/section/sign_up/sign_up_mobile_scree.dart';
import 'package:amlak_app/screens/tab%20bar/tab_bar_screen.dart';
import 'package:amlak_app/utils/auth_manager.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/auth/check_login/login_bloc.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fluttertoast.showToast;

  await getItInit();
  final SharedPreferences _sharedPreferences = locator.get();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String token = AuthMnager.readAuth();

    return MaterialApp(
      builder: FToastBuilder(),
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(fontFamily: 'IR', snackBarTheme: SnackBarThemeData()),
      home: token.isEmpty
          ? BlocProvider(
              create: (context) => CheckLoginBloc(),
              child: LoginDesktopScreen(),
            )
          : const HomeScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
