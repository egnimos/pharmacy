import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pharmacy/models/prescription.dart';
import 'package:pharmacy/screens/Dashboard/upload_prescription_page.dart';
import 'package:pharmacy/widgets/prescription_card_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/color_theme.dart';
import '../widgets/toast_widget.dart';

class MyPrescriptions extends StatefulWidget {
  const MyPrescriptions({Key? key}) : super(key: key);

  @override
  _MyPrescriptionsState createState() => _MyPrescriptionsState();
}

class _MyPrescriptionsState extends State<MyPrescriptions> {
  List<Prescription> myTodaysPrescriptions = [];
  List<Prescription> myRemaningPrescriptions = [];
  bool isLoading = false;
  @override
  void initState() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    getPrescriptions().then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  Future<void> getPrescriptions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('access_token');
      final header = {
        'Authorization': 'Bearer $auth',
      };
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/listprescription/?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: header,
      );
      print('response get $header');
      print('response get ${response.body}');
      final model = json.decode(response.body);
      List<Prescription> myPrescriptions = [];
      if (response.statusCode == 200) {
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          for (var pres in model["data"]) {
            myPrescriptions.add(Prescription.fromJson(pres));
          }
          final formatted = DateFormat().add_yMd().format(DateTime.now());
          myTodaysPrescriptions = myPrescriptions
              .where((pres) =>
                  DateFormat()
                      .add_yMd()
                      .format(DateTime.parse(pres.createdAt)) ==
                  formatted)
              .toList();
          myRemaningPrescriptions = myPrescriptions
              .where((pres) =>
                  DateFormat()
                      .add_yMd()
                      .format(DateTime.parse(pres.createdAt)) !=
                  formatted)
              .toList();
          setState(() {});
        }
      } else {
        showToast(model["msg"].toString());
      }
    } catch (error) {
      print('exception ----- $error');
      showToast(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'My Prescription',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomSheet: Container(
        height: 65,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadPrescriptionPage(),
              ),
            );
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColor.appTheme,
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: Text(
              'Upload Prescription',
              style: GoogleFonts.nunitoSans(
                color: AppColor.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: CircularProgressIndicator()),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                if (myTodaysPrescriptions.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Today",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (myTodaysPrescriptions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: PrescriptionCardWidget(
                      pres: myTodaysPrescriptions,
                    ),
                  ),
                if (myRemaningPrescriptions.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 16.0,
                    ),
                    child: Text(
                      "This Week",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (myRemaningPrescriptions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: PrescriptionCardWidget(
                      pres: myRemaningPrescriptions,
                    ),
                  ),
              ],
            ),
    );
  }
}

class FullScreenView extends StatelessWidget {
  final String img;
  const FullScreenView({
    Key? key,
    required this.img,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View"),
        elevation: 0,
        backgroundColor: AppColor.appTheme,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(img),
      ),
    );
  }
}
