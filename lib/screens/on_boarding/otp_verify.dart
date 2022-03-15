import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';
import '../navigation_screen.dart';

class OtpVerify extends StatefulWidget {
  final String mobile;
  const OtpVerify({Key? key, required this.mobile}) : super(key: key);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  String _pin = "";
  bool isLoading = false;

  Future otpVerify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // progressHUD.state.show();
    setState(() {
      isLoading = true;
    });
    try {
      var auth = prefs.getString('access_token');
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/varifyotp?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&otp_code=$_pin&mobile=${widget.mobile}',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
        body: {
          'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
          'currency': 'INR',
          'otp_code': _pin,
          'mobile': widget.mobile,
        },
      );
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
          prefs.setBool('isLogin', true);
          prefs.setString('access_token', model['access_token']);
          setState(() {
            USERTOKEN = model['access_token'].toString();
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // progressHUD.state.dismiss();
      showToast(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.fontColor, width: 2),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/icons/Compound Path@1X.png',
                color: AppColor.fontColor,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Phone Verification',
              style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.fontColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Enter the 6-digit code you received in SMS ',
              style: GoogleFonts.nunitoSans(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColor.fontColor,
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            showOTP(),
            const SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () {
                if (_pin.length < 4) {
                  showToast('Please enter pin');
                } else {
                  otpVerify();
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
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Verify',
                        style: GoogleFonts.nunitoSans(
                          color: AppColor.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Didn\'t receive a code? Resend',
                style: GoogleFonts.nunitoSans(
                  fontSize: 15,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showOTP() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      // textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 40,
      fieldStyle: FieldStyle.underline,
      style: GoogleFonts.nunitoSans(fontSize: 17),
      onChanged: (pin) {},
      onCompleted: (pin) {
        _pin = pin;
      },
    );
  }
}
