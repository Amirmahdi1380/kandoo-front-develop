import 'dart:ui';

import 'package:amlak_app/bloc/auth/register/register_event.dart';
import 'package:amlak_app/bloc/check_otp_verify/otp_verify_bloc.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../bloc/auth/register/register_bloc.dart';
import '../../bloc/auth/register/register_state.dart';
import '../../responsive/responsive.dart';
import '../../utils/validation.dart';
import '../otp/otp_verify_mobile_screen.dart';

class SignInDesktopScreen extends StatefulWidget {
  @override
  _SignInDesktopScreenState createState() => _SignInDesktopScreenState();
}

class _SignInDesktopScreenState extends State<SignInDesktopScreen> {
  final _formKey = GlobalKey<FormState>();
  Jalali? picked;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  FToast? fToast;
  void initState() {
    BlocProvider.of<RegisterBloc>(context).add(RegisterStartEvent());
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterResponseState) {
            return state.response.fold((l) {
              if (mobileNumberController.text.isNotEmpty &&
                  mobileNumberController.text.length == 11 &&
                  mobileNumberController.text.isValidIranianMobileNumber() &&
                  nationalIdController.text.isValidIranianNationalCode()) {
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
                      const Icon(Icons.warning , color: Colors.white,),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(l, style: const TextStyle(fontFamily: 'IR' , color: Colors.white)),
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
              Navigator.of(context).push(
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
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: Responsive.isTablet(context)
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
                        Stack(
                          children: [
                            Image.asset('assets/images/banner.png'),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'نام',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا نام خود را وارد کنید';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'نام خانوادگی',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا نام خانوادگی خود را وارد کنید';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              onTap: () async {
                                picked = await showPersianDatePicker(
                                    context: context,
                                    initialDate: Jalali.now(),
                                    firstDate: Jalali(1300, 4),
                                    lastDate: Jalali(1450, 4));
                                setState(() {
                                  dobController.text =
                                      "${picked!.year.toString()}/${picked!.month.toString()}/${picked!.day.toString()}"
                                          .toPersianDigit();
                                });
                              },
                              keyboardType: TextInputType.number,
                              controller: dobController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'تاریخ تولد',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا تاریخ تولد خود را وارد کنید';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              controller: nationalIdController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'کد ملی',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: validationNationalCode,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              controller: mobileNumberController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'شماره موبایل',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: validationbileNumber,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 50),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                              BlocProvider.of<RegisterBloc>(context).add(
                                RegisterRequestEvent(
                                  firstNameController.text,
                                  lastNameController.text,
                                  nationalIdController.text.toEnglishDigit(),
                                  mobileNumberController.text.toEnglishDigit(),
                                  '${picked!.toGregorian().year}-${picked!.toGregorian().month}-${picked!.toGregorian().day}',
                                ),
                              );
                            },
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
