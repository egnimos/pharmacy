import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/screens/Dashboard/upload_prescription.dart';

import '../../theme/color_theme.dart';

class UploadPrescriptionPage extends StatelessWidget {
  const UploadPrescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        centerTitle: true,
        title: const Text(
          'Upload Prescription',
          style: TextStyle(
            color: AppColor.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 10, left: 20.0),
              child: Text(
                'How Dawa Doctor Works?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: Image.asset('assets/icons/Group 123.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 20.0),
              child: Text(
                'Valid Prescription Guide',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20.0, right: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Don’t crop out any part of the image',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20.0, right: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Avoid blurred image',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20.0, right: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Include details of doctor and patient + clinic visit date',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 20.0, right: 15, bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Medicines will be dispensed as per prescription',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadPrescription(),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.appTheme,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Next',
                    style: GoogleFonts.nunitoSans(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Image.asset('assets/icons/Image 137.png'),
          ],
        ),
      ),
    );
  }
}
