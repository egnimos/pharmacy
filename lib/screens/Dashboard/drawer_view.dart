import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/screens/Dashboard/upload_prescription_page.dart';
import 'package:pharmacy/screens/about_us.dart';
import 'package:pharmacy/screens/faqs.dart';
import 'package:pharmacy/screens/navigation_screen.dart';
import 'package:pharmacy/screens/offers_discount.dart';
import 'package:pharmacy/screens/on_boarding/sign_in_screen.dart';
import 'package:pharmacy/screens/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import 'view_category_products.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  var year;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    var date = DateFormat('yyyy');
    String formattedDate = date.format(now);
    setState(() {
      year = formattedDate.toString();
    });
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColor.whiteColor,
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/ic_home@1X.png'),
              text: 'Shop By Medicine',
              onTap: () {},
            ),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/ic_prescription@1X.png'),
              text: 'Upload Prescription',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadPrescriptionPage(),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/ic_eappointment@1X.png'),
              text: 'OTC & Wellness',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewCategoryProducts(
                      catId: 12,
                      heading: "OTC",
                    ),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/Group 6484@1X.png'),
              text: 'My Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(
                      currentTab: 4,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            createDrawerBodyItem(
              icon: const Icon(Icons.settings),
              text: 'Offers & Discounts ',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OffersDiscount(),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/ic_faqs@1X.png'),
              text: 'FAQs & Help',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FaqsHelp(),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Image.asset('assets/icons/ic_prescription@1X.png'),
              text: 'Privacy and Terms',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy(),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: const Icon(Icons.info),
              text: 'About Us',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: const Icon(Icons.logout),
              text: 'Logout',
              onTap: () {
                logoutUser();
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Divider(
                thickness: 1.0,
                height: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 70,
                  width: 60,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/appTheme.png',
                        fit: BoxFit.contain,
                      ),
                      Text(
                        year,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

Widget createDrawerHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      color: AppColor.whiteColor,
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 30,
          left: 20.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 85.0,
                height: 85.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius: new BorderRadius.all(
                  //   new Radius.circular(50.0),
                  // ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  Text(
                    USERNAME,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 9.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.email,
                        color: AppColor.whiteColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          USEREMAIL,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // heightSizedBox(5.0),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget createDrawerBodyItem(
    {required icon, required String text, required GestureTapCallback onTap}) {
  return ListTile(
    // tileColor: themeColor,
    title: Row(
      children: <Widget>[
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
    trailing: const Icon(
      Icons.arrow_forward_ios_outlined,
      color: Colors.white,
    ),
  );
}
