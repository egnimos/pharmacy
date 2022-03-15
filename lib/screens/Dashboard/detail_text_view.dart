import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/color_theme.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _DescriptionTextWidgetState createState() =>
      _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 130) {
      firstHalf = widget.text.substring(0, 90);
      secondHalf = widget.text.substring(90, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              textAlign: TextAlign.start,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            )
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        flag ? "Show More" : "Show Less",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: AppColor.appTheme,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
