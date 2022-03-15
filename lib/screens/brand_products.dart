import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/screens/Dashboard/product_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/color_theme.dart';
import '../widgets/toast_widget.dart';

class BrandProducts extends StatefulWidget {
  final int brandId;
  final String brandName;
  const BrandProducts({
    Key? key,
    required this.brandId,
    required this.brandName,
  }) : super(key: key);
  @override
  _BrandProductsState createState() => _BrandProductsState();
}

class _BrandProductsState extends State<BrandProducts> {
  List brandsProducts = [];
  bool isLoading = false;

  @override
  void initState() {
    getBrandsProduc();
    super.initState();
  }

  getBrandsProduc() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/brands/${widget.brandId}/products?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      var model = json.decode(response.body);
      print('aaaaaa $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          setState(() {
            brandsProducts = model['products'];
          });
        }
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

  @override
  Widget build(BuildContext context) {
    print('sfds $brandsProducts');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: Text(
          widget.brandName,
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
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            // ignore: unnecessary_null_comparison
            : brandsProducts == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('No Data found'),
                    ),
                  )
                : Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 25,
                        ),
                        itemCount: brandsProducts.length,
                        itemBuilder: (context, i) {
                          var discount = ((brandsProducts[i]['price'] -
                                      brandsProducts[i]['offer_price']) /
                                  brandsProducts[i]['price']) *
                              100;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    id: brandsProducts[i]['id'],
                                    variantid: 000,
                                    from: 'category',
                                    data: [],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColor.fontColor, width: 1),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/images/appTheme.png",
                                          image:
                                              'https://dawadoctor.co.in/images/simple_products/' +
                                                  brandsProducts[i]
                                                      ['thumbnail'],
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.fill,
                                          imageErrorBuilder: (_, __, ___) {
                                            return Container(
                                              height: 100,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/appTheme.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Image.network(
                                      //   // brandsProducts[i]['thumbnail_path'] +
                                      //   'https://dawadoctor.co.in/images/simple_products/' +
                                      //       brandsProducts[i]['thumbnail'],
                                      //   height: 100,
                                      //   width:
                                      //       MediaQuery.of(context).size.width,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      const Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(Icons.favorite_border)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      brandsProducts[i]['product_name']['en'],
                                      maxLines: 2,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 15,
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // brandsProducts[i]['symbol']
                                        //         .toString() +
                                        '₹' +
                                            brandsProducts[i]['offer_price']
                                                .toString(),
                                        maxLines: 2,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 13.5,
                                          color: AppColor.fontColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        // brandsProducts[i]['symbol']
                                        //         .toString() +
                                        '₹' +
                                            brandsProducts[i]['price']
                                                .toString(),
                                        maxLines: 2,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 13.5,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${discount.toStringAsFixed(2)}% OFF',
                                        maxLines: 2,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 13.5,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
      ),
    );
  }
}
