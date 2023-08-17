import 'dart:ui';

import 'package:amlak_app/bloc/auth/check_login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../bloc/auth/check_login/login_event.dart';
import '../../bloc/auth/check_login/login_state.dart';
import '../../bloc/check_otp_verify/otp_verify_bloc.dart';
import '../../bloc/check_otp_verify/otp_verify_event.dart';
import '../../bloc/check_otp_verify/otp_verify_state.dart';
import '../../responsive/responsive.dart';
import '../../screens/Home_screen.dart';

class OtpVerifyDesktopScreen extends StatefulWidget {
  String mobileNumber;
  OtpVerifyDesktopScreen(this.mobileNumber, {super.key});

  @override
  State<OtpVerifyDesktopScreen> createState() => _OtpVerifyDesktopScreenState();
}

class _OtpVerifyDesktopScreenState extends State<OtpVerifyDesktopScreen> {
  FToast? fToast;
  void initState() {
    BlocProvider.of<OtpVerifyBloc>(context).add(OtpVerifyInitEvent());
    fToast = FToast();
    fToast!.init(context);
  }

  OtpFieldController otpController = OtpFieldController();
  TextEditingController _otpControllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<OtpVerifyBloc, OtpVerifyState>(
          listener: (context, state) {
            if (state is OtpVerifyResponse) {
              state.getcheckOtp.fold((l) {
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
                      Text(
                        l,
                        style: const TextStyle(
                            fontFamily: 'IR', color: Colors.white),
                      ),
                    ],
                  ),
                );

                fToast!.showToast(
                  child: toast,
                  gravity: ToastGravity.TOP,
                  toastDuration: Duration(seconds: 2),
                );
              }, (r) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ),
                );
              });
            } else if (state is OtpVerifyClearSms) {
              _otpControllerText.clear();
            }
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  color: Colors.blue
                      .withOpacity(0.2), // Adjust the opacity as desired
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.width * 0.8
                        : 800,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              child: Image.asset('assets/images/banner.png'),
                            ),
                            Positioned(
                              top: 1,
                              left: 6,
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  padding: const EdgeInsets.only(left: 2),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color(0xff123A99),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ورود رمز پیامک شده",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.message_rounded),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Center(
                            child: OTPTextField(
                              length: 5,
                              controller: otpController,
                              width: 400,
                              fieldWidth: 45,
                              style: const TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (value) {
                                if (value.isNotEmpty) {
                                  _otpControllerText.text = value;
                                  BlocProvider.of<OtpVerifyBloc>(context).add(
                                    OtpVerifyButtonClick(
                                      widget.mobileNumber,
                                      _otpControllerText.text.toEnglishDigit(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                            //height: 20,
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_otpControllerText.text.isNotEmpty) {
                              BlocProvider.of<OtpVerifyBloc>(context).add(
                                  OtpVerifyButtonClick(widget.mobileNumber,
                                      _otpControllerText.text));
                            }
                          },
                          child: const Text("تایید"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OtpTimerButton(
                                //controller: controller,
                                height: 60,
                                text: const Text(
                                  'ارسال مجدد کد',
                                ),
                                duration: 30,
                                radius: 30,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                buttonType: ButtonType
                                    .text_button, // or ButtonType.outlined_button
                                loadingIndicator:
                                    const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.red,
                                ),
                                loadingIndicatorColor: Colors.red,
                                onPressed: () {
                                  // BlocProvider.of(context)
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
