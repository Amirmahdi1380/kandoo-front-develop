import 'package:amlak_app/bloc/auth/check_login/login_bloc.dart';
import 'package:amlak_app/bloc/auth/check_login/login_event.dart';
import 'package:amlak_app/bloc/check_otp_verify/otp_verify_bloc.dart';
import 'package:amlak_app/bloc/check_otp_verify/otp_verify_event.dart';
import 'package:amlak_app/screens/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../bloc/check_otp_verify/otp_verify_state.dart';

class OtpVerifyScreen extends StatefulWidget {
  String mobileNumber;
  OtpVerifyScreen(this.mobileNumber, {super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  void initState() {
    BlocProvider.of<OtpVerifyBloc>(context).add(OtpVerifyInitEvent());
    // BlocProvider.of<CheckLoginBloc>(context).add(CheckLoginButtonClick(widget.mobileNumber));
  }

  OtpFieldController otpController = OtpFieldController();
  TextEditingController _otpControllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: BlocListener<OtpVerifyBloc, OtpVerifyState>(
          listener: (context, state) {
            if (state is OtpVerifyResponse) {
              state.getcheckOtp.fold((l) {
               Fluttertoast.showToast(
                  msg: l,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red[800],
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

                // Step 3
                //ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }, (r) {
                Fluttertoast.showToast(
                  msg: r,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey[800],
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              });
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 191,
                  child: Image.asset('assets/images/banner.png'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ورود رمز پیامک شده",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.message_rounded),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: OTPTextField(
                      length: 5,
                      controller: otpController,
                      width: 400,
                      fieldWidth: 50,
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      // onChanged: (value) {
                      //   _otpControllerText.text = value;
                      // },
                      onCompleted: (value) {
                        _otpControllerText.text = value;
                        BlocProvider.of<OtpVerifyBloc>(context).add(
                            OtpVerifyButtonClick(
                                widget.mobileNumber, _otpControllerText.text.toEnglishDigit()));
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
                    //print(_otpControllerText.text);
                    BlocProvider.of<OtpVerifyBloc>(context).add(
                        OtpVerifyButtonClick(
                            widget.mobileNumber, _otpControllerText.text));
                    // if (state is OtpVerifyStartState) {
                    //   CircularProgressIndicator();
                    // }
                  },
                  child: Text("تایید"),
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
                        duration: 60,
                        radius: 30,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        buttonType: ButtonType
                            .text_button, // or ButtonType.outlined_button
                        loadingIndicator: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                        loadingIndicatorColor: Colors.red,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
