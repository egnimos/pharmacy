import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class FaqsHelp extends StatefulWidget {
  const FaqsHelp({Key? key}) : super(key: key);

  @override
  _FaqsHelpState createState() => _FaqsHelpState();
}

class _FaqsHelpState extends State<FaqsHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'FAQs And Help',
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
