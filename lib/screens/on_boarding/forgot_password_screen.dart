import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/constants/input_form_field.dart';

import '../../theme/color_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.fontColor, width: 1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/Path 403@1X.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                'Forgot Password',
                style: GoogleFonts.nunitoSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColor.fontColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your Email or Phone number. You will receive a code to create a new password.',
                style: GoogleFonts.nunitoSans(
                  color: AppColor.fontColor,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                height: 70,
                child: AllInputDesign(
                  controller: phoneController,
                  labelText: 'Email or Phone Number',
                  suffixIcon: const Icon(Icons.call),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                  ),
                  inputborder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: AppColor.appTheme,
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.nunitoSans(
                    color: AppColor.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
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
