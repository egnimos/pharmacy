import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController newcnfPassController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  changePass() async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var auth = prefs.getString('access_token');
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/changepass?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        body: {
          'old_password': oldPassController.text,
          'password_confirmation': newPassController.text,
          'password': newcnfPassController.text
        },
        headers: {'Authorization': 'Bearer $auth'},
      );
      var model = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          Navigator.pop(context);
          showToast(model["msg"].toString());
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (error) {
      print('xxxxxxxx$error');
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.appTheme,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.nunitoSans(
            color: AppColor.whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: oldPassController,
                    labelText: 'Old Password',
                    // suffixIcon: const Icon(Icons.account_circle),
                    validatorFieldValue: validatePassword,
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
                    controller: newPassController,
                    labelText: 'New Password',
                    // suffixIcon: const Icon(Icons.account_circle),
                    validatorFieldValue: validatePassword,
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
                    controller: newcnfPassController,
                    labelText: 'Confirm New Password',
                    // suffixIcon: const Icon(Icons.account_circle),
                    validatorFieldValue: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is Required.';
                      } else if (value != newPassController.text) {
                        return 'Confirm Password is wronge.';
                      }
                      return null;
                    },
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
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      changePass();
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
                            'Change Password',
                            style: GoogleFonts.nunitoSans(
                              color: AppColor.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
