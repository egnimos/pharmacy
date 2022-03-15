import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/order.dart';
import 'package:pharmacy/widgets/order_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:pharmacy/screens/MyOrders/my_order_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  List myOrders = [];
  late TabController _tabController;
  final int _currentIndex = 0;
  // ignore: unused_field
  int _selectedIndex = 0;
  bool isLoading = false;
  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: 2, initialIndex: _currentIndex);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    getOrdersData();
    super.initState();
  }

  Future getOrdersData() async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var auth = prefs.getString('access_token');
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/all-order?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {
          'Authorization': 'Bearer ${auth ?? USERTOKEN}',
        },
      );
      var model = json.decode(response.body);
      print('response data-- ${model['orders']['data'].length}');
      print('response data-- $model');
      if (response.statusCode == 200) {
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          setState(() {
            isLoading = false;
          });
          showToast(model["msg"].toString());
        } else {
          setState(() {
            isLoading = false;
            myOrders = model['orders']['data'];
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('exception ----- $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.appTheme,
          title: Text(
            'My Orders',
            style: GoogleFonts.nunitoSans(
              fontSize: 18,
              color: AppColor.whiteColor,
            ),
          ),
          centerTitle: true,
        ),
        body:
            // first tab bar view widget
            upCommingOrders(),
      ),
    );
  }

  upCommingOrders() {
    return isLoading
        ? const Center(
            child: SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount:
                myOrders.length, //mSlidesModel['categories']['items'].length,
            itemBuilder: (context, i) {
              final order = Order.fromJson(myOrders[i]);
              return OrderWidget(
                order: order,
              );
            });
  }

  Widget pastOrders() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemCount: myOrders.length,
            itemBuilder: (context, i) {
              var productDetail = myOrders[i]['invoices'][0];
              return Column(
                children: [
                  if (myOrders[i]['invoices'][0]['status'] == 'delivered') ...[
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 120,
                      padding: const EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColor.fontColor, width: 0.3),
                        color: AppColor.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetail['variant'] == null
                                ? productDetail['simple_product']
                                    ['product_name']['en']
                                : productDetail['variant']['product_name']
                                    ['en'],
                            maxLines: 3,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            children: [
                              Text(
                                'Order ID:' + myOrders[i]['order_id'],
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                productDetail['variant'] == null
                                    ? '₹${productDetail['simple_product']['price']}'
                                    : '₹${productDetail['variant']['price']}',
                                maxLines: 1,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            productDetail['status'],
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              );
            }),
      ),
    );
  }
}
