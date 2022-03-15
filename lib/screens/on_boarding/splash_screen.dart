import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/constants/data_manager.dart';
import 'package:pharmacy/screens/navigation_screen.dart';
import 'package:pharmacy/screens/on_boarding/on_boarding_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProgressHUD? progressHUD;
  @override
  void initState() {
    progressHUD = ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
    );
    getData();
    super.initState();
  }

  var year;
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    var date = DateFormat('yyyy');
    String formattedDate = date.format(now);
    setState(() {
      year = formattedDate.toString();
    });
    var auth = prefs.getBool('isLogin') ?? false;
    Timer(const Duration(seconds: 3), () {
      auth
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationPage(),
              ),
              (Route<dynamic> route) => false,
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnBoardingScreen(),
              ),
            );
    });
    setState(() {
      DataManager.getInstance()
          .setBaseUrl("https://dawadoctor.co.in/public/api/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/Image 104.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.86),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/scooter.png',
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/Dawan doctor final logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/img_onboarding_.png',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$year ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.copyright_outlined,
                    size: 20,
                  ),
                  const Text(
                    'Dawa Doctor',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
