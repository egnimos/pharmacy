import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geopoint_location/geopoint_location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:pharmacy/constants/validations.dart';
import 'package:pharmacy/screens/Dashboard/drawer_view.dart';
import 'package:pharmacy/screens/Dashboard/upload_prescription_page.dart';
import 'package:pharmacy/screens/Dashboard/view_all_categories.dart';
import 'package:pharmacy/screens/MyCart/my_cart.dart';
import 'package:pharmacy/screens/notifications.dart';
import 'package:pharmacy/screens/search_page.dart';
import 'package:pharmacy/widgets/buttons_widget.dart';

import 'package:pharmacy/widgets/slider_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../services/cart_service.dart';
import '../../services/utility_service.dart';
import '../../theme/color_theme.dart';
import '../../widgets/brand_widget.dart';
import '../../widgets/category_widget.dart';
import '../../widgets/products_list_widget.dart';
import '../../widgets/toast_widget.dart';
import '../search_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController pinController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  // var mSlidesModel;
  // ignore: prefer_typing_uninitialized_variables
  var addresss;
  // ignore: prefer_typing_uninitialized_variables
  var pinCode;
  bool isLoading2 = false;
  bool isLoading = false;
  bool _isInit = true;
  // LatLng _center;
  // late Position currentLocation;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      loadInfo();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> loadInfo() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await Provider.of<UtilityService>(context, listen: false).getHomeInfo();
    // await getSliderData();
    await checkLocation();
    await getProfile();
    await Provider.of<CartService>(context, listen: false).getCartProducts();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loc = prefs.getBool('isLocation') ?? false;
    if (loc) {
      setState(() {
        pinCode = prefs.getString('pin_code');
        addresss = prefs.getString('location');
      });
    } else {
      getUserLocation();
    }
  }

  Widget appTitle() {
    return Row(
      children: [
        Image.asset(
          'assets/images/appTheme.png',
          height: 50,
          width: 50,
          fit: BoxFit.contain,
        ),
        Text(
          'Dawa Doctor',
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            color: AppColor.appTheme,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  List<Widget> actionWidgets() {
    return <Widget>[
      cartButton(context, AppColor.appTheme),
      notificationButton(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.whiteColor,
        title: appTitle(),
        actions: actionWidgets(),
        iconTheme: const IconThemeData(
          color: AppColor.appTheme,
          size: 35,
        ),
      ),
      drawer: const DrawerView(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Your Location',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addresss == null
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  '${addresss ?? ''} ${pinCode ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                      GestureDetector(
                        onTap: () => getUserLocation(),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Change',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchProd(),
                        );
                      },
                      child: AllInputDesign(
                        contentPadding: 10.0,
                        labelText: 'Search Medicine & Lab Test',
                        enabled: false,
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        validatorFieldValue: validateMobile,
                        keyBoardType: TextInputType.number,
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
                ),
                const Divider(
                  thickness: 1,
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
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
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.orangeColor,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_sharp,
                            size: 20,
                            color: AppColor.whiteColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Upload Your Prescription',
                            style: GoogleFonts.nunitoSans(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                //catgories
                Consumer<UtilityService>(
                  builder: (context, us, child) => SizedBox(
                    // height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: us.categories.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Category',
                                      style: GoogleFonts.nunitoSans(
                                        color: AppColor.fontColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAllCategories(
                                              heading: 'All Categories',
                                              imagePath:
                                                  us.homeInfo.categoryImagePath,
                                              categories: us.categories,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.nunitoSans(
                                          color: Colors.grey,
                                          fontSize: 17,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Categories(
                                categories: us.categories,
                                imagePath: us.homeInfo.categoryImagePath,
                              ),
                            ],
                          ),
                  ),
                ),

                //special offers
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Special Offers',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                      color: AppColor.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 10),
                  child: Text(
                    'Get special discounts and offers on Medicine',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                        color: AppColor.fontColor, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 20),

                //sliders
                Consumer<UtilityService>(
                  builder: (context, us, child) => SliderWidget(
                    offers: us.offers,
                    sliderPath: us.homeInfo.sliderPath,
                  ),
                ),
                const SizedBox(height: 15),

                //brands
                Consumer<UtilityService>(
                  builder: (context, us, child) => us.brands.isEmpty
                      ? const SizedBox.shrink()
                      : BrandWidget(
                          brands: us.brands,
                        ),
                ),

                const SizedBox(height: 15),

                //featured products
                Consumer<UtilityService>(
                  builder: (context, us, child) => us.brands.isEmpty
                      ? const SizedBox.shrink()
                      : ProductsWidget(
                          products: us.products,
                          heading: 'Feature Products',
                        ),
                ),
                const SizedBox(height: 40),
              ],
            ),
    );
  }

  bool isLoad = false;

  getUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            insetPadding: const EdgeInsets.all(10),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 360,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/icons/ic_location.png'),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Enable Delivery Pincode',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: AllInputDesign(
                      contentPadding: 10.0,
                      controller: pinController,
                      labelText: 'Add New Pincode',
                      validatorFieldValue: validateLocation,
                      keyBoardType: TextInputType.number,
                      suffixIcon: const Icon(Icons.location_on),
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
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoad = true;
                      });
                      final geoPoint = await geoPointFromLocation(
                        name: "Current position",
                        withAddress: true,
                      );
                      setState(() {
                        addresss = geoPoint.locality;
                        pinCode = geoPoint.postalCode.toString();
                      });
                      setState(() {});
                      prefs.setBool('isLocation', true);
                      prefs.setString('location', addresss.toString());
                      prefs.setString(
                        'pin_code',
                        geoPoint.postalCode.toString(),
                      );
                      setState(() {
                        isLoad = false;
                      });
                      Navigator.pop(context);
                    },
                    child: isLoad
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.location_searching,
                                color: AppColor.appTheme,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Use My Current Location',
                                style: TextStyle(
                                  color: AppColor.appTheme,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (pinController.text.isEmpty) {
                        showToast("Please add pincode");
                      } else {
                        setState(() {
                          pinCode = pinController.text;
                          addresss = '';
                        });
                        prefs.setBool('isLocation', true);
                        prefs.setString('location', addresss.toString());
                        prefs.setString(
                          'pin_code',
                          pinController.text.toString(),
                        );
                        setState(() {});
                        Navigator.pop(context);
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
                      child: isLoad
                          ? const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Submit',
                              style: GoogleFonts.nunitoSans(
                                color: AppColor.whiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {
          'Authorization': 'Bearer ${auth ?? USERTOKEN}',
        },
      );
      final model = json.decode(response.body);
      if (response.statusCode == 200) {
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          print('----------------$model');
          setState(() {
            USERNAME = model['name'];
            USEREMAIL = model['email'];
            USERIMG = model['image'];
          });
        }
      } else {
        showToast(model["msg"].toString());
      }
    } catch (error) {
      showToast(error.toString());
    }
  }

  // Future<void> getSliderData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // progressHUD.state.show();
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         'https://dawadoctor.co.in/public/api/homepage?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
  //       ),
  //       // headers:headers,
  //     );
  //     print('tutions sdflj sdjf weri sldf jfd${response.body}');

  //     var model = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       // progressHUD.state.dismiss();
  //       if (model["status"] == 'fail') {
  //         showToast(model["msg"].toString());
  //       } else {
  //         print('----------------${model['featuredProducts']}');
  //         setState(() {
  //           mSlidesModel = model;
  //           APPTHEME = model['appheaders']['logopath'] +
  //               '/' +
  //               model['appheaders']['logo'];
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       showToast(model["msg"].toString());
  //     }
  //   } catch (error) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showToast(error.toString());
  //   }
  // }
}
