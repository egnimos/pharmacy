import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/models/prescription.dart';
import 'package:pharmacy/widgets/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import '../../widgets/bottom_modals.dart';
import '../../widgets/toast_widget.dart';

class UploadPrescription extends StatefulWidget {
  const UploadPrescription({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<UploadPrescription> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late File file;
  final ImagePicker _picker = ImagePicker();
  File? img;
  // var ggg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Upload Prescription',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: nameController,
                    labelText: 'Name',
                    validatorFieldValue: validateName,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: mobileController,
                    labelText: 'Mobile',
                    validatorFieldValue: validateMobile,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    inputborder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xfff0f0f0)),
                    ),
                    keyBoardType: TextInputType.phone,
                  ),
                ),
                GestureDetector(
                  onTap: () => showPicker(context, pickFile: (imageSrc) async {
                    await _pickImage(imageSrc);
                  }),
                  child: Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xfff0f0f0),
                    ),
                    alignment: Alignment.centerLeft,
                    child: img != null
                        ? Center(
                            child: Image.file(
                              img!,
                            ),
                          ) //Text(img.path)
                        : const Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15),
                            child: Text('Add Attechment'),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      final pres = Prescription(
                        id: 0,
                        userId: 0,
                        phone: mobileController.text,
                        name: nameController.text,
                        imageName: "",
                        createdAt: "",
                        updatedAt: "",
                      );
                      await submitPres(pres, img);
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      alertForPrescription(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppColor.appTheme,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Upload',
                            style: GoogleFonts.nunitoSans(
                              color: AppColor.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitPres(Prescription pres, File? file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      var headers = {'Authorization': 'Bearer ${auth??USERTOKEN}'};
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://dawadoctor.co.in/public/api/createprescription?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
      );
      request.fields.addAll(pres.toJson());
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image_uploads',
            file.path,
          ),
        );
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        showToast('prescription uploaded successfully');
      }
    } catch (error) {
      showToast(error.toString());
    }
  }

  _pickImage(ImageSource imgsrc) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxHeight: 300,
      maxWidth: 400,
    );
    if (pickedFile != null) {
      setState(() {
        img = File(pickedFile.path);
      });
    }
    print("picked file:: $img");
  }
}
