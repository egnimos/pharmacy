import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/screens/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../widgets/toast_widget.dart';

class GoogleSigninProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user!;

  Future googleLogin(context) async {
    await googleSignIn.signIn().then((result) {
      result!.authentication.then((googleKey) async {
        try {
          final response = await http.post(
            Uri.parse(
              'https://dawadoctor.co.in/public/api/social-login?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
            ),
            body: {
              'name': googleSignIn.currentUser!.displayName.toString(),
              'email': googleSignIn.currentUser!.email.toString(),
            },
          );
          var model = json.decode(response.body);
          if (response.statusCode == 200) {
            if (model["status"] == 'fail') {
              showToast(model["msg"].toString());
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogin', true);
              prefs.setString('access_token', model['access_token']);
              USERTOKEN = model['access_token'];
              USEREMAIL = googleSignIn.currentUser!.email.toString();
              USERNAME = googleSignIn.currentUser!.displayName.toString();
              return Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationPage(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          } else {
            // progressHUD.state.dismiss();
            showToast(model["msg"].toString());
          }
        } catch (e) {}
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }
}
