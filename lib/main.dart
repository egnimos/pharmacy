import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/on_boarding/signin_provider.dart';
import 'package:pharmacy/screens/on_boarding/splash_screen.dart';
import 'package:pharmacy/services/address_service.dart';
import 'package:pharmacy/services/cart_service.dart';
import 'package:pharmacy/services/payment_service.dart';
import 'package:pharmacy/services/user_service.dart';
import 'package:pharmacy/theme/color_theme.dart';
import 'package:provider/provider.dart';

import 'services/brand_service.dart';
import 'services/category_service.dart';
import 'services/product_service.dart';
import 'services/utility_service.dart';

const brandImagePath = "https://dawadoctor.co.in/public/images/brands";
// ignore: non_constant_identifier_names
int CARTCOUNT = 0;
// ignore: non_constant_identifier_names
String USERTOKEN = "";
// ignore: non_constant_identifier_names
String USEREMAIL = "";
// ignore: non_constant_identifier_names
String USERNAME = "";
// ignore: non_constant_identifier_names
String APPTHEME = "";
// ignore: non_constant_identifier_names
String USERIMG = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSigninProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressService(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilityService(),
        ),
        ChangeNotifierProvider(
          create: (context) => BrandService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // color: AppColor.appTheme,
      home: const SplashScreen(),
    );
  }
}
