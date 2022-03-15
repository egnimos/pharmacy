import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class OffersDiscount extends StatefulWidget {
  const OffersDiscount({Key? key}) : super(key: key);

  @override
  _OffersDiscountState createState() => _OffersDiscountState();
}

class _OffersDiscountState extends State<OffersDiscount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Offers And Discount',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: Text('No Data Found'),
          ),
        ),
      ),
    );
  }
}
