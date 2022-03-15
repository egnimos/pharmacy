import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class OTCAndWellness extends StatefulWidget {
  const OTCAndWellness({Key? key}) : super(key: key);

  @override
  _OTCAndWellnessState createState() => _OTCAndWellnessState();
}

class _OTCAndWellnessState extends State<OTCAndWellness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'OTC And Wellness',
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
