import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class LabTestShedule extends StatefulWidget {
  const LabTestShedule({Key? key}) : super(key: key);

  @override
  _LabTestSheduleState createState() => _LabTestSheduleState();
}

class _LabTestSheduleState extends State<LabTestShedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Lab Test Schedule',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
