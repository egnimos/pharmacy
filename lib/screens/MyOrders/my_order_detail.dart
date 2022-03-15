import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/constants/input_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class MyOrderDetail extends StatefulWidget {
  final String id;

  const MyOrderDetail({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _MyOrderDetailState createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail> {
  late String baseURL;
  bool isLoading = false;
  bool isAddToCart = false;
  // ignore: unused_field
  final int _current = 0;
  // ignore: prefer_typing_uninitialized_variables
  var mSlidesModel;
  List listimg = [];
  var ratingr = 3.0;

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  Future getProductData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('access_token');
    var url =
        'https://dawadoctor.co.in/public/api/view/order/${widget.id}?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR';
    try {
      final response = await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          'Authorization': 'Bearer ${auth ?? USERTOKEN}',
        },
      );
      var model = json.decode(response.body);
      print('rrrrrr $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();

        setState(() {
          mSlidesModel = model['order'];
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // progressHUD.state.dismiss();
      showToast(error.toString());
    }
  }

  Widget rowText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //orderId
        Expanded(
          child: Text(
            '#987jkdlasmd2002220jkhdkl',
            maxLines: 1,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        //track order
        Flexible(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColor.greenColor,
                width: 2.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              primary: AppColor.greenColor,
            ),
            onPressed: () {},
            child: const Text(
              "Track Order",
              style: TextStyle(
                color: AppColor.greenColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget priceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //item
              Text(
                'Ocean Oat Meal Stout',
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              //counts
              Text(
                "x 3 items",
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        //order total
        RichText(
          text: TextSpan(
            text: "₹ ",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: "19.08",
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  color: AppColor.fontColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget chargesRow({
    required String leading,
    required String trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$leading ',
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Colors.grey.shade900,
            ),
            maxLines: 2,
          ),
          RichText(
            text: TextSpan(
              text: "₹ ",
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: trailing,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Order Detail',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColor.whiteColor,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //order id
                    rowText(),
                    //date
                    Transform.translate(
                      offset: const Offset(0.0, -10.0),
                      child: Text(
                        "2022-03-12",
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    //delivered to
                    Text(
                      "Delivered to",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),
                    //address
                    Text(
                      '1633 Hamington Meadows Lexinton',
                      maxLines: 1,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    //payment method
                    Text(
                      "Payment method",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),
                    //method
                    Text(
                      'COD',
                      maxLines: 1,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Divider(
                      endIndent: 5.0,
                      indent: 5.0,
                      color: Colors.grey.shade700,
                      height: 15.0,
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    //items
                    priceRow(),
                    priceRow(),
                    priceRow(),
                    priceRow(),

                    const SizedBox(
                      height: 10.0,
                    ),

                    Divider(
                      endIndent: 5.0,
                      indent: 5.0,
                      color: Colors.grey.shade700,
                      height: 15.0,
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    //total
                    chargesRow(leading: "item total", trailing: "23.04"),
                    chargesRow(leading: "Delivery Charges", trailing: "3.04"),
                    chargesRow(leading: "Discount", trailing: "0.0"),

                    const SizedBox(
                      height: 10.0,
                    ),

                    Divider(
                      endIndent: 5.0,
                      indent: 5.0,
                      color: Colors.grey.shade700,
                      height: 15.0,
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Paid ',
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade900,
                          ),
                          maxLines: 2,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "₹ ",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                text: "26.08",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.fontColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
