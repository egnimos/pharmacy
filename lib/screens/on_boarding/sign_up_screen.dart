import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/screens/on_boarding/mobile_verify.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isCheck = false;
  bool isLoading = false;
  Future signUp() async {
    // progressHUD.state.show();
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('https://dawadoctor.co.in/public/api/register'),
        // headers:headers,
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'mobile': phoneController.text,
          'name': fullNameController.text
        },
      );
      print('----------------${response.body}');
      var model = json.decode(response.body);
      if (response.statusCode == 200) {
        // progressHUD.state.dismiss();
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('access_token', model['access_token']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MobileVerify(),
            ),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
      // progressHUD.state.dismiss();
      showToast(Exepction.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.fontColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 25, right: 35),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(
                    'assets/images/Dawan doctor final logo.png',
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: fullNameController,
                    labelText: 'Full Name',
                    suffixIcon: const Icon(Icons.person),
                    validatorFieldValue: validateName,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: emailController,
                    labelText: 'Email Address',
                    validatorFieldValue: validateEmail,
                    suffixIcon: const Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: phoneController,
                    labelText: 'Phone Number',
                    validatorFieldValue: validateMobile,
                    keyBoardType: TextInputType.number,
                    suffixIcon: const Icon(Icons.call),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: dobController,
                    labelText: 'Date of Birth',
                    // validatorFieldValue: validateEmail,
                    suffixIcon: const Icon(Icons.calendar_today_rounded),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: passwordController,
                    labelText: 'Password',
                    validatorFieldValue: validatePassword,
                    suffixIcon: const Icon(Icons.lock),
                    obscureText: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isCheck,
                      activeColor: AppColor.appTheme,
                      onChanged: (e) {
                        setState(() {
                          isCheck = e!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By selecting this and signing up, you agree to our Terms & Policy.',
                        style: GoogleFonts.nunitoSans(
                          color: AppColor.fontColor,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppColor.appTheme,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Sign Up',
                            style: GoogleFonts.nunitoSans(
                              color: AppColor.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account ',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      color: AppColor.fontColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        style: GoogleFonts.nunitoSans(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
