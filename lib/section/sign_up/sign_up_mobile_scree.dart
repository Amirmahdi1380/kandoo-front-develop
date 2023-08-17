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
import '../../utils/validation.dart';
import '../otp/otp_verify_mobile_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  Jalali? picked;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<RegisterBloc>(context).add(RegisterStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterResponseState) {
            return state.response.fold((l) {
              Fluttertoast.showToast(
                msg: l,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[500],
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }, (r) {
              var snackBar = const SnackBar(
                content: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text("ثبت نام با موفقیت انجام شد!")),
                backgroundColor: Colors.green,
              );
              // Step 3
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 191,
                  child: Image.asset('assets/images/banner.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
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
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
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
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onTap: () async {
                              picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1300, 4),
                                  lastDate: Jalali(1450, 4));
                              setState(() {
                                dobController.text =
                                    "${picked!.year.toString()}/${picked!.month.toString()}/${picked!.day.toString()}";
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
                                return 'Please enter your date of birth';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
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
                            validator:validationbileNumber,
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 50),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform sign-in functionality here
                                String firstName = firstNameController.text;
                                String lastName = lastNameController.text;
                                String dob = picked.toString();
                                String nationalId = nationalIdController.text;
                                String mobileNumber =
                                    mobileNumberController.text;

                                // Print the values for testing
                                print('First Name: $firstName');
                                print('Last Name: $lastName');
                                print('Date of Birth: $dob');
                                print('National ID: $nationalId');
                                print('Mobile Number: $mobileNumber');
                              }
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
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
