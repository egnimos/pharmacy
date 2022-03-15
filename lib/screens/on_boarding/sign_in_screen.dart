import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/screens/navigation_screen.dart';
import 'package:pharmacy/screens/on_boarding/otp_verify.dart';
import 'package:pharmacy/screens/on_boarding/signin_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCheck = false;
  bool isLoading = false;
  bool isLoading3 = false;
  final GlobalKey<ScaffoldState> _mScaffoldKey = GlobalKey<ScaffoldState>();
  static final FacebookLogin facebookSignIn = FacebookLogin();
  String name = '', image = '';
  Future logInpApi() async {
    // progressHUD.state.show();
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse(
            'https://dawadoctor.co.in/public/api/checkmobile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR'),
        body: {
          'secret': 'secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
          'mobile': emailController.text,
          // 'password': passwordController.text,
        },
      );
      print('asdfghjklkjhgf${response.body}');
      var model = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'success') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerify(mobile: emailController.text),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          showToast(model["msg"].toString());
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
      backgroundColor: AppColor.appTheme,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/ob.png',
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 35),
                  height: MediaQuery.of(context).size.height * 0.75,
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
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: Image.asset(
                            'assets/images/Dawan doctor final logo.png',
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 85,
                          child: AllInputDesign(
                            controller: emailController,
                            labelText: 'Mobile Number',
                            suffixIcon: const Icon(Icons.call),
                            validatorFieldValue: validateMobile,
                            keyBoardType: TextInputType.number,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            inputborder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              logInpApi();
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
                                    'Sign In',
                                    style: GoogleFonts.nunitoSans(
                                      color: AppColor.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isLoading3 = true;
                                });
                                final FacebookLoginResult result =
                                    await facebookSignIn.logIn(['email']);
                                setState(() {
                                  isLoading3 = false;
                                });
                                switch (result.status) {
                                  case FacebookLoginStatus.loggedIn:
                                    final FacebookAccessToken accessToken =
                                        result.accessToken;
                                    try {
                                      setState(() {
                                        isLoading3 = true;
                                      });
                                      final graphResponse = await http.get(
                                          Uri.parse(
                                              'https://graph.facebook.com/v2.12/me?fields=first_name,email,picture&access_token=${accessToken.token}'));
                                      final profile =
                                          jsonDecode(graphResponse.body);
                                      print('''
                                             Logged in!       
                                             Token: ${accessToken.token}
                                             User id: ${accessToken.userId}
                                             Expires: ${accessToken.expires}
                                             Permissions: ${accessToken.permissions}
                                             Declined permissions: ${accessToken.declinedPermissions}
                                             ''');
                                      try {
                                        final response = await http.post(
                                          Uri.parse(
                                            'https://dawadoctor.co.in/public/api/social-login?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
                                          ),
                                          body: {
                                            'name': profile['first_name']
                                                .toString(),
                                            'email': profile['email'],
                                          },
                                        );
                                        var model = json.decode(response.body);
                                        setState(() {
                                          isLoading3 = false;
                                        });
                                        if (response.statusCode == 200) {
                                          if (model["status"] == 'fail') {
                                            showToast(model["msg"].toString());
                                          } else {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool('isLogin', true);
                                            prefs.setString(
                                                'access_token',
                                                model['access_token']
                                                    .toString());
                                            USERTOKEN = model['access_token'];
                                            USEREMAIL =
                                                profile['email'].toString();
                                            USERNAME = profile['first_name']
                                                .toString();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NavigationPage(),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        } else {
                                          // progressHUD.state.dismiss();
                                          showToast(model["msg"].toString());
                                        }
                                      } catch (e) {}
                                    
                                    } catch (e) {
                                      print('===================== $e');
                                    }
                                    break;
                                  case FacebookLoginStatus.cancelledByUser:
                                    print('Login cancelled by the user.');
                                    break;
                                  case FacebookLoginStatus.error:
                                    print(
                                        'Something went wrong with the login process.\n'
                                        'Here\'s the error Facebook gave us: ${result.errorMessage}');
                                    break;
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color(0xff3A55A0),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/ic_facebook.png'),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Facebook',
                                      style: GoogleFonts.nunitoSans(
                                        color: AppColor.whiteColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final provider =
                                    Provider.of<GoogleSigninProvider>(context,
                                        listen: false);
                                provider.googleLogin(context);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Color(0xffEA4235),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/google-fill.png'),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Google',
                                      style: GoogleFonts.nunitoSans(
                                        color: AppColor.whiteColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // progressHUD,
          Align(
            alignment: Alignment.center,
            child: isLoading3 ? const CircularProgressIndicator() : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
