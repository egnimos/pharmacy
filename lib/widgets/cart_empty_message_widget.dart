import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/navigation_screen.dart';
import '../theme/color_theme.dart';

class CartEmptyMessageWidget extends StatelessWidget {
  const CartEmptyMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Column(
          children: [
            const Text('Empty cart'),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(
                      currentTab: 0,
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColor.appTheme,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Explore',
                  style: GoogleFonts.nunitoSans(color: AppColor.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
