// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:salon/pages/otp_verification.dart';
import 'package:salon/utils/colors.dart';
import 'package:salon/utils/comman_variable.dart';

class AskMobileNumberPage extends StatefulWidget {
  const AskMobileNumberPage({super.key});

  @override
  State<AskMobileNumberPage> createState() => _AskMobileNumberPageState();
}

class _AskMobileNumberPageState extends State<AskMobileNumberPage> {
  final TextEditingController controller = TextEditingController();

  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.appbackgroundColor,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipPath(
                  clipper: SinCosineWaveClipper(),
                  // borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(340, 180)),

                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/onboarding3.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      'Send OTP For Verification To\nYour Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.13)),
                    // boxShadow: const [
                    //   // BoxShadow(
                    //   //   color: Color(0xffeeeeee),
                    //   //   blurRadius: 10,
                    //   //   offset: Offset(0, 4),
                    //   // ),
                    // ],
                  ),
                  child: Stack(
                    children: [
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        textFieldController: controller,
                        formatInput: false,
                        maxLength: 13,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.black,
                        inputDecoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () async {
                    await mobileNo(context, controller.text);
                  },
                  child: Container(
                    // // padding: const EdgeInsets.all(32),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Center(
                        child: Text(
                      'SEND OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ]),
        ),
      ),
    );
  }



  Future<dynamic> mobileNo(BuildContext context, String number) async {
    print('mobileNo Function Called');

    // Retrieve the email from Shared Preferences
    String? email = await SharedPrefs.getEmail();

    if (email == null) {
      print('Error: Email not found in Shared Preferences');
      return null;
    }

    print("$email ::: $number ");
    final String apiUrl = 'https://ontimesalon.com/api/User_Numberupdate.php';

    try {
      var map = Map<String, dynamic>();
      map['email'] = email;
      map['number'] = number;

      var res = await http.post(
        Uri.parse(apiUrl),
        body: map,
      );

      print("Data sent");
      if (res.statusCode == 200) {
        print('Success: ${res.body}');
      } else if (res.statusCode == 400) {
        print('Client Error: ${res.body}');
      } else {
        print('Server Error: ${res.statusCode}');
      }

      if (jsonDecode(res.body)['status'] == 'success') {
        await SharedPrefs.saveNumber(number);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPVerificationPage(),
          ),
        );
      }
      return res;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }

}
