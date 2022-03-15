import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../theme/color_theme.dart';
import '../widgets/toast_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  bool isLoading = false;
  List wishlistData = [];
  @override
  void initState() {
    getProductData();
    super.initState();
  }

  Future getProductData() async {
    print('get request url ');
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/wishlist?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14%27',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      var model = json.decode(response.body);
      print('api response $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          setState(() {
            wishlistData = model['data'];
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future removeWishlist(id) async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/wishlist/remove/$id?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14%27',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      var model = json.decode(response.body);
      print('api response $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          getProductData();
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('asdfasdfasdf ${wishlistData.length}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        centerTitle: true,
        title: Text(
          'Wishlist',
          style: GoogleFonts.nunitoSans(
            color: AppColor.whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      scrollDirection: Axis.vertical,
                      itemCount: wishlistData.length,
                      itemBuilder: (context, i) {
                        var name;
                        var price;
                        var mainPrice;
                        var image;
                        var ids;
                        if (wishlistData[i]['variant'] == null) {
                          name = wishlistData[i]['simple_product']
                              ['product_name']['en'];
                          mainPrice =
                              wishlistData[i]['simple_product']['price'];
                          price =
                              wishlistData[i]['simple_product']['offer_price'];
                          image =
                              wishlistData[i]['simple_product']['thumbnail'];
                          ids = wishlistData[i]['simple_product']['id'];
                        } else {}
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                               
                              },
                              child: Container(
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
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.fontColor),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://dawadoctor.co.in/public/images/simple_products/' +
                                                image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5),
                                          Text(
                                            name ?? '',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹$mainPrice',
                                                maxLines: 1,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '₹$price',
                                                maxLines: 1,
                                                style: GoogleFonts.nunitoSans(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                 
                                          const SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                removeWishlist(ids);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: AppColor.appTheme,
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    top: 5,
                                                    bottom: 5),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                     
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                             
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
