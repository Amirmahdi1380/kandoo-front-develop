import 'dart:ui';

import 'package:amlak_app/responsive/responsive.dart';
import 'package:amlak_app/section/sign_up/sign_up_desktop_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../bloc/auth/check_login/login_bloc.dart';
import '../../bloc/auth/check_login/login_event.dart';
import '../../bloc/auth/check_login/login_state.dart';
import '../../bloc/auth/register/register_bloc.dart';
import '../../bloc/check_otp_verify/otp_verify_bloc.dart';
import '../../bloc/projects/project_bloc.dart';
import '../../utils/validation.dart';
import '../otp/otp_verify_desktop_screen.dart';

import '../project_detail/desktop/project_desktop_container.dart';
import '../project_detail/mobile/project_mobile_container.dart';
import 'login_mobile_screen.dart';

class LoginDesktopScreen extends StatefulWidget {
  LoginDesktopScreen({super.key});

  @override
  State<LoginDesktopScreen> createState() => _LoginDesktopScreenState();
}

class _LoginDesktopScreenState extends State<LoginDesktopScreen> {
  final _formKey = GlobalKey<FormState>();
  FToast? fToast;
  void initState() {
    fToast = FToast();
    fToast!.init(context);
  }

  final TextEditingController mobileNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CheckLoginBloc, CheckLoginState>(
        listener: (context, state) {
          if (state is CheckLoginResponse) {
            state.getCheck.fold((l) {
              if (mobileNumberController.text.isNotEmpty &&
                  mobileNumberController.text.length == 11 &&
                  mobileNumberController.text.isValidIranianMobileNumber()) {
                Widget toast = Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xff2196F3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(l,
                          style: const TextStyle(
                              fontFamily: 'IR', color: Colors.white)),
                    ],
                  ),
                );

                fToast!.showToast(
                  child: toast,
                  gravity: ToastGravity.TOP,
                  toastDuration: Duration(seconds: 2),
                );
              }
            }, (r) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => OtpVerifyBloc(),
                      child:
                          OtpVerifyDesktopScreen(mobileNumberController.text),
                    );
                  },
                ),
              );
            });
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                color: const Color.fromARGB(255, 33, 150, 243)
                    .withOpacity(0.2), // Adjust the opacity as desired
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.width * 0.8
                              : 800,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/images/banner.png'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                        maxLength: 11,
                                        keyboardType: TextInputType.number,
                                        controller: mobileNumberController,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(7),
                                            ),
                                          ),
                                          labelText: 'شماره موبایل',
                                          labelStyle: TextStyle(
                                            fontSize:
                                                Responsive.isDesktop(context)
                                                    ? 16
                                                    : 12,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        validator: validationbileNumber),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(142, 50),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(7),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {}

                                      BlocProvider.of<CheckLoginBloc>(context)
                                          .add(
                                        CheckLoginButtonClick(
                                          mobileNumberController.text
                                              .toEnglishDigit(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'ورود',
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? 16
                                            : 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) => RegisterBloc(),
                                            child: SignInDesktopScreen(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "ثبت نام",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 16
                                          : 12,
                                      color: Colors.blue,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocProvider(
                    create: (context) => ProjectBloc(),
                    child: const GetProjectDesktopContainer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
