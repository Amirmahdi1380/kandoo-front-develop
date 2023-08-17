import 'dart:math';

import 'package:amlak_app/bloc/auth/check_login/login_event.dart';
import 'package:amlak_app/bloc/auth/register/register_bloc.dart';
import 'package:amlak_app/bloc/check_otp_verify/otp_verify_bloc.dart';
import 'package:amlak_app/section/otp/otp_verify_mobile_screen.dart';
import 'package:amlak_app/section/sign_up/sign_up_mobile_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../bloc/auth/check_login/login_bloc.dart';
import '../../bloc/auth/check_login/login_state.dart';
import '../../bloc/projects/project_bloc.dart';
import '../../bloc/projects/project_event.dart';
import '../../bloc/projects/project_state.dart';
import '../../utils/validation.dart';
import '../../widgets/container_builder_mobile_projects.dart';
import '../project_detail/mobile/project_mobile_container.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    BlocProvider.of<CheckLoginBloc>(context).add(CheckLoginInitEvent());
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileNumberController = TextEditingController();

  Widget build(BuildContext context) {
    bool isButtonPressed = false;
    return Scaffold(
      body: BlocListener<CheckLoginBloc, CheckLoginState>(
        listener: (context, state) {
          if (state is CheckLoginResponse) {
            state.getCheck.fold((l) {
              if (mobileNumberController.text.isNotEmpty &&
                  mobileNumberController.text.length == 11) {
                Fluttertoast.showToast(
                  msg: l,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red[500],
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            }, (r) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => OtpVerifyBloc(),
                      child: OtpVerifyScreen(mobileNumberController.text),
                    );
                  },
                ),
              );
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 191,
                child: Image.asset('assets/images/banner.png'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.number,
                            controller: mobileNumberController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              labelText: 'شماره موبایل',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: validationbileNumber),
                        const SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(142, 50),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<CheckLoginBloc>(context).add(
                                  CheckLoginButtonClick(mobileNumberController
                                      .text
                                      .toEnglishDigit()));
                              if (_formKey.currentState!.validate()) {
                                String mobileNumber =
                                    mobileNumberController.text;
                                print('Mobile Number: $mobileNumber');
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ورود'),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) => RegisterBloc(),
                                      child: SignInScreen(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "ثبت نام",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocProvider(
                          create: (context) => ProjectBloc(),
                          child: const GetProjectMobileContainer(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget message(String error) {
  return Text(error);
}
