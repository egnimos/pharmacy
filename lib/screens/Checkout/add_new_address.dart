import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/address.dart' as address;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/services/address_service.dart';
import 'package:provider/provider.dart';

import '../../theme/color_theme.dart';
import '../../widgets/modals.dart';

class AddNewAddress extends StatefulWidget {
  final address.Address? addressInfo;
  final String from;
  const AddNewAddress({
    Key? key,
    this.addressInfo,
    required this.from,
  }) : super(key: key);
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  bool isLoading = false;
  bool isSaving = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool home = false;
  bool work = false;
  bool _isInit = true;
  List countryList = [];
  List citiesList = [];
  address.State? stateInfo;
  address.Country? countryInfo;
  address.City? cityInfo;

  String stateName = 'State';
  String cityName = 'City';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      if (widget.addressInfo != null) {
        setState(() {
          fullNameController.text = widget.addressInfo?.name ?? "";
          emailController.text = widget.addressInfo?.email ?? "";
          addressController.text = widget.addressInfo?.address ?? "";
          cityController.text = widget.addressInfo?.city.name ?? "";
          stateController.text = widget.addressInfo?.state.name ?? "";
          countryController.text = widget.addressInfo?.country.name ?? "";
          pinController.text = widget.addressInfo?.pincode ?? "";
          mobileController.text = widget.addressInfo?.phone ?? "";
        });
      }
      Provider.of<AddressService>(context, listen: false)
          .geCountryList()
          .then((value) {
        countryInfo =
            Provider.of<AddressService>(context, listen: false).countries.first;

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Add New Address',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: fullNameController,
                    labelText: 'Full Name',
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
                    controller: emailController,
                    labelText: 'Email',
                    validatorFieldValue: validateEmail,
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
                    labelText: 'Mobile Number',
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
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: AllInputDesign(
                    controller: addressController,
                    labelText: 'Address',
                    validatorFieldValue: validateAddress,
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
                    controller: landmarkController,
                    labelText: 'Landmark',
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
                    controller: pinController,
                    labelText: 'Pin Code',
                    validatorFieldValue: validatePin,
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

                //country & state
                Row(
                  children: [
                    //COUNTRY NAME
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          alignment: isLoading
                              ? Alignment.center
                              : Alignment.centerLeft,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  countryInfo?.name ?? "Country",
                                  style: const TextStyle(color: Colors.black),
                                ),
                        ),
                      ),
                    ),
                    Container(width: 10.0),

                    //STATE NAME
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalForStates(context,
                              countryId: countryInfo?.id ?? 0,
                              selectedStateInfo: (value) {
                            setState(() {
                              stateInfo = value;
                            });
                          });
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xfff0f0f0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            stateInfo?.name ?? "state",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //city info
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalForCities(context,
                                stateId: stateInfo?.id ?? 0,
                                selectedCityInfo: (value) {
                              setState(() {
                                cityInfo = value;
                              });
                            });
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xfff0f0f0),
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              cityInfo?.name ?? "city",
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "RobotoReguler",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //type of address
                const Text(
                  'Type of Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor.fontColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          home = true;
                          work = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: home ? AppColor.appTheme : Colors.transparent,
                          border: Border.all(
                              color: home ? AppColor.appTheme : Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_filled,
                              color: home ? AppColor.whiteColor : AppColor.fontColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Home',
                              style: GoogleFonts.nunitoSans(
                                color: home ? AppColor.whiteColor : AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          work = true;
                          home = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: work ? AppColor.appTheme : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: work ? AppColor.appTheme : Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: work ? AppColor.whiteColor : AppColor.fontColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'work',
                              style: GoogleFonts.nunitoSans(
                                color: work ? AppColor.whiteColor : AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isSaving = true;
                      });

                      final addressInfo = address.Address(
                        id: 0,
                        name: fullNameController.text,
                        phone: mobileController.text,
                        pincode: pinController.text,
                        email: emailController.text,
                        address: addressController.text,
                        country: address.Country(
                            id: countryInfo?.id ?? 0,
                            name: countryInfo?.name ?? ""),
                        state: address.State(
                            id: stateInfo?.id ?? 0,
                            name: stateInfo?.name ?? ""),
                        city: address.City(
                            id: cityInfo?.id ?? 0, name: cityInfo?.name ?? ""),
                        defAddress: 1,
                        type: home ? 'Home' : 'Office',
                      );

                      await Provider.of<AddressService>(context, listen: false)
                          .addAddress(context, widget.from, addressInfo);
                      setState(() {
                        isSaving = false;
                      });
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
                    child: isSaving
                        ? const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Save Address',
                            style: GoogleFonts.nunitoSans(
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
        ),
      ),
    );
  }
}
