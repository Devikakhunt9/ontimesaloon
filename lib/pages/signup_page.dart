import 'dart:convert';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:salon/pages/otp_page.dart';
import 'package:salon/pages/login_page.dart';
import 'package:salon/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:salon/utils/comman_variable.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');

    if (!isEmailValid) {
      return 'please enter a valid email';
    }
    return null;
  }

  TextEditingController confirmpass = TextEditingController();
  bool obsecuretxt = true;
  bool confrimobsecuretxt = true;
  bool isChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5));

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
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              hintText: 'Enter mail Id',
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              ///
                              Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              suffixIcon: GestureDetector(
                                child: obsecuretxt
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 16,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        size: 16,
                                      ),
                                onTap: () {
                                  setState(() {
                                    // ignore: avoid_print
                                    print(obsecuretxt);
                                    obsecuretxt = !obsecuretxt;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              hintText: 'Type password',
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: obsecuretxt,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please Enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              ///
                              Text(
                                'Confirm Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              suffixIcon: GestureDetector(
                                child: confrimobsecuretxt
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 16,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        size: 16,
                                      ),
                                onTap: () {
                                  setState(() {
                                    confrimobsecuretxt = !confrimobsecuretxt;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              hintText: 'Type password',
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: confrimobsecuretxt,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please Enter your password";
                              }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          if(value!.isNotEmpty && value!=_passwordController.text){
                                return "password and Confirm Password must be same";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.8, // Scale the checkbox size
                                child: Checkbox(
                                  side: const BorderSide(color: Colors.white),
                                  shape: const BeveledRectangleBorder(),
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  checkColor: Colors.blue,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'I accept the ',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'policy and terms',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightBlue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Handle policy tap
                                          // ignore: avoid_print
                                          print('Policy tapped');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          isLoading
                              ? CircularProgressIndicator() // Add this line
                              : InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate() &&
                                  isChecked == true) {
                                signUp(
                                    _nameController.text,
                                    _passwordController.text,
                                    _confirmPasswordController.text) ;

                              }
                            },
                            child: Container(
                              // // padding: const EdgeInsets.all(32),
                              // margin: const EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                  child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white54),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Signin',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
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
      ),
    );
  }

  Future<dynamic> signUp(String email, String pass, String confirmpass) async {
    setState(() {
      isLoading = true;  // Add this line
    });
    print('Sign Up Function Called');
    print("$email ::: $pass :::: $confirmpass");
    final String apiUrl =
        'https://ontimesalon.com/api/user_register.php';
    try {


      var map = Map<String, dynamic>();
      map['email'] = email;
      map['password'] = pass;
      map['cnfpassword'] = confirmpass;
      var res = await http.post(Uri.parse(apiUrl), body: map, );
      print("Data sent");
      if (res.statusCode == 200) {
        print('Success: ${res.body}');
      } else if (res.statusCode == 400) {
        print('Client Error: ${res.body}');
      } else {
        print('Server Error: ${res.statusCode}');
      }
      if(jsonDecode(res.body)['status']=='success'){
        await SharedPrefs.saveEmail(email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const AskMobileNumberPage(),
          ),
        );
      }
      return res;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
      return null;
    }finally {
      setState(() {
        isLoading = false;  // Add this line
      });
    }
  }
}
