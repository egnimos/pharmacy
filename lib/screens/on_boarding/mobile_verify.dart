import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/screens/on_boarding/otp_verify.dart';

import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class MobileVerify extends StatefulWidget {
  const MobileVerify({Key? key}) : super(key: key);

  @override
  _MobileVerifyState createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Future mobileVerify() async {
    // progressHUD.state.show();
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('https://dawadoctor.co.in/public/api/register'),
        // headers:headers,
        body: {
          'mobile': phoneController.text,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerify(
                mobile: phoneController.text,
              ),
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
    } catch (error) {
      setState(() {
        isLoading = false;
      });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Form(
            key: formKey,
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
                  'Your Phone Number',
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
                  'Please enter your contact no. A 5-digit code will be sent to your phone.',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: phoneController,
                    labelText: 'Phone Number',
                    validatorFieldValue: validateMobile,
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
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtpVerify(mobile: phoneController.text),
                        ),
                      );
                      //   showToast('Please enter pin');
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
                        : const Text(
                            'Continuew',
                            style: TextStyle(
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
        ),
      ),
    );
  }
}
