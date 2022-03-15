import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/color_theme.dart';

Future<void> showToast(message) {
  return Fluttertoast.showToast(
    gravity: ToastGravity.BOTTOM,
    msg: message.toString(),
    backgroundColor: Colors.green.shade300,
    textColor: AppColor.whiteColor,
  );
}