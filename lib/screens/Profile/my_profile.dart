import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/constants/common_widgets.dart';
import 'package:pharmacy/models/user.dart';
import 'package:pharmacy/screens/Profile/affiliates_screen.dart';
import 'package:pharmacy/screens/Profile/change_password.dart';
import 'package:pharmacy/screens/Profile/edit_profile.dart';
import 'package:pharmacy/screens/my_addresses.dart';
import 'package:pharmacy/screens/my_prescriptions.dart';
import 'package:pharmacy/screens/notifications.dart';
import 'package:pharmacy/screens/on_boarding/sign_in_screen.dart';
import 'package:pharmacy/screens/payment_history.dart';
import 'package:pharmacy/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/user_service.dart';
import '../../theme/color_theme.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  User? userInfo;
  bool isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      Provider.of<UserService>(context, listen: false).getUser().then((_) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserService>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            'Profile',
            style: GoogleFonts.nunitoSans(
              color: AppColor.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notifications(),
                ),
              );
            },
            icon: Image.asset(
              'assets/icons/Path 4617@1X.png',
              height: 20,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 28, right: 28, bottom: 25),
                      color: AppColor.appTheme,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  border: Border.all(
                                      color: AppColor.whiteColor, width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    'https://dawadoctor.co.in/images/user/${userInfo?.image}',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userInfo?.name ?? '',
                                    style: GoogleFonts.nunitoSans(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      userInfo?.email ?? '',
                                      maxLines: 2,
                                      style: GoogleFonts.nunitoSans(
                                        color: AppColor.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfile(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xff2D3D4A),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    color: AppColor.whiteColor, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    commonListTile(
                      'Wishlist',
                      const Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Wishlist(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'My Prescription',
                      Image.asset(
                        'assets/icons/prescription.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyPrescriptions(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Payment Method',
                      Image.asset(
                        'assets/icons/paymethod.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {},
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Your Addressess',
                      Image.asset(
                        'assets/icons/add.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyAddresses(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Payment History',
                      Image.asset(
                        'assets/icons/historypay.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentHistory(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Affiliates',
                      Image.asset(
                        'assets/icons/invite.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AffiliatesScreen(
                              referCode: userInfo?.referCode ?? "no-code",
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Change Password',
                      Image.asset(
                        'assets/icons/key.png',
                        height: 25,
                        color: AppColor.fontColor,
                      ),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePassword(),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    commonListTile(
                      'Logout',
                      const Icon(
                        Icons.logout,
                        size: 25,
                        color: AppColor.fontColor,
                      ),
                      () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLogin', false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 15,
                      indent: 25,
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
    );
  }

  Widget commonListTile(title, icon, onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: AppColor.fontColor,
        ),
      ),
      leading: icon,
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.grey,
        size: 20,
      ),
    );
  }
}
