import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/models/user.dart';
import 'package:pharmacy/widgets/bottom_modals.dart';
import 'package:provider/provider.dart';

import '../../services/user_service.dart';
import '../../theme/color_theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bgController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  // var profileData;
  bool isLoading = false;
  bool male = false;
  bool female = false;
  bool _isInit = true;
  String? netImage;
  final ImagePicker _picker = ImagePicker();
  File? img;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final user = Provider.of<UserService>(context, listen: false).user;
      setState(() {
        nameController.text = user.name;
        emailController.text = user.email;
        mobileController.text = user.mobile;
        weightController.text = user.weight;
        heightController.text = user.height;
        ageController.text = user.age;
        bgController.text = user.bloodGroup;
        netImage = user.image;
        male = user.gender == 'male';
        female = user.gender == 'female';
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.appTheme,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.nunitoSans(
            color: AppColor.whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 28, right: 28, bottom: 25),
                    color: AppColor.appTheme,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              showPicker(context, pickFile: (imageSrc) async {
                            await _pickImage(imageSrc);
                          }),
                          child: Stack(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  border: Border.all(
                                      color: AppColor.whiteColor, width: 2),
                                ),
                                child: img != null
                                    ? Container(
                                        margin: const EdgeInsets.all(2),
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(img!),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: netImage == null
                                            ? const SizedBox.shrink()
                                            : Image.network(
                                                'https://dawadoctor.co.in/images/user/$netImage',
                                              ),
                                      ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameController.text,
                              style: GoogleFonts.nunitoSans(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              emailController.text,
                              style: GoogleFonts.nunitoSans(
                                color: AppColor.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      'Personal Information',
                      style: GoogleFonts.nunitoSans(
                        color: AppColor.fontColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 85,
                          child: AllInputDesign(
                            controller: nameController,
                            labelText: 'Full Name',
                            suffixIcon: const Icon(Icons.account_circle),
                            validatorFieldValue: validateEmail,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            inputborder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.only(left: 15, right: 35),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: const Color(0xfff0f0f0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        male = true;
                                        female = false;
                                      });
                                    },
                                    icon: male
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppColor.appTheme,
                                          )
                                        : const Icon(
                                            Icons.circle,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  const Text('Male'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        male = false;
                                        female = true;
                                      });
                                    },
                                    icon: female
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppColor.appTheme,
                                          )
                                        : const Icon(
                                            Icons.circle,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 85,
                          child: AllInputDesign(
                            controller: mobileController,
                            labelText: 'Mobile Number',
                            suffixIcon: const Icon(Icons.call),
                            validatorFieldValue: validateMobile,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            inputborder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 85,
                          child: AllInputDesign(
                            controller: emailController,
                            labelText: 'Email Address',
                            suffixIcon: const Icon(Icons.email),
                            validatorFieldValue: validateEmail,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                            inputborder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 0, color: Color(0xfff0f0f0)),
                            ),
                          ),
                        ),
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 85,
                                child: AllInputDesign(
                                  labelText: 'Age',
                                  controller: ageController,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  inputborder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 85,
                                child: AllInputDesign(
                                  labelText: 'Blood Group',
                                  controller: bgController,
                                  suffixIcon: const Text(''),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  inputborder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 85,
                                child: AllInputDesign(
                                  labelText: 'Height',
                                  controller: heightController,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  inputborder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 85,
                                child: AllInputDesign(
                                  labelText: 'Weight',
                                  controller: weightController,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                  inputborder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 0, color: Color(0xfff0f0f0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final user = User(
                              email: emailController.text,
                              mobile: mobileController.text,
                              age: ageController.text,
                              bloodGroup: bgController.text,
                              gender: female ? 'female' : 'male',
                              height: heightController.text,
                              name: nameController.text,
                              weight: weightController.text,
                              image: "",
                              referCode: "U-f2689",
                            );
                            await Provider.of<UserService>(context,
                                    listen: false)
                                .updateUser(user, img);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColor.appTheme,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            alignment: Alignment.center,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Update Profile',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    // print("picked file:: $img");
  }
}
