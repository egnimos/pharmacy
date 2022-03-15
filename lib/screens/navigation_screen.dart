import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/screens/Dashboard/dashboard.dart';
import 'package:pharmacy/screens/MyOrders/my_orders.dart';
import 'package:pharmacy/screens/Profile/my_profile.dart';
import 'package:animations/animations.dart';

import '../theme/color_theme.dart';
import 'Dashboard/view_category_products.dart';

class NavigationPage extends StatefulWidget {
  final int currentTab;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  NavigationPage({Key? key, this.currentTab = 0}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _NavigationPageState createState() => _NavigationPageState(currentTab);
}

class _NavigationPageState extends State<NavigationPage> {
  int currentTab;
  _NavigationPageState(this.currentTab);
  final List<Widget> _widgets = [
    const DashBoard(),
    const ViewCategoryProducts(
      catId: 1,
      heading: 'Medicines',
    ),
    const ViewCategoryProducts(
      catId: 11,
      heading: "LAB TEST",
    ),
    const MyOrders(),
    const MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: Stack(
        children: <Widget>[
          PageTransitionSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (
              Widget child,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                child: child,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
              );
            },
            child: Container(
              key: ValueKey<int>(currentTab),
              child: _widgets[currentTab],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentTab,
        onTap: (index) => setState(() {
          currentTab = index;
        }),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.nunitoSans(
          color: AppColor.appTheme,
          fontSize: 13,
        ),
        unselectedLabelStyle: GoogleFonts.nunitoSans(
          color: Colors.grey,
          fontSize: 12,
        ),
        selectedItemColor: AppColor.appTheme,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/appTheme.png',
              height: 26,
              color: currentTab == 0 ? AppColor.appTheme : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/noun_News feed_729137.png',
              height: 20,
              color: currentTab == 1 ? AppColor.appTheme : Colors.grey,
            ),
            label: 'Medicines',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services_rounded,
            ),
            label: 'Lab tests',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/carticon.png',
              height: 24,
              color: currentTab == 3 ? AppColor.appTheme : Colors.grey,
            ),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_profile.png',
              height: 20,
              color: currentTab == 4 ? AppColor.appTheme : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
