import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/screens/Dashboard/detail_text_view.dart';
import 'package:pharmacy/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../services/product_service.dart';
import '../../theme/color_theme.dart';
import '../../widgets/toast_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final id;
  final int variantid;
  final String from;
  final data;

  const ProductDetailScreen({
    Key? key,
    required this.id,
    this.variantid = 000,
    required this.from,
    required this.data,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String baseURL;
  bool isLoading = false;
  bool fromWishlist = false;
  bool isAddToCart = false;
  bool isInWishList = false;
  int _current = 0;
  // var mSlidesModel;
  late Product product;
  List listimg = [];
  var ratingr = 3.0;

  //MAIN CATEGORIES MEDICINE (change the order for the product detail, place the salt composition to the top), OTC, LAB (Key feature & description)
  @override
  void initState() {
    if (widget.variantid == 000) {
      setState(() {
        baseURL =
            'http://dawadoctor.co.in/api/simpledetails/${widget.id}?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR';
      });
    } else {
      setState(() {
        baseURL =
            'https://dawadoctor.co.in/public/api/details/${widget.id}/${widget.variantid}?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR';
      });
    }
    getProductData();
    super.initState();
  }

  Future<void> getProductData() async {
    print('get request url $baseURL');
    if (!fromWishlist) {
      setState(() {
        isLoading = true;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          baseURL,
        ),
        headers: {
          'Authorization': 'Bearer ${auth ?? USERTOKEN}',
        },
      );
      final jsonBody = json.decode(response.body);
      print('00000000000000 $jsonBody');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (jsonBody["status"] == 'fail') {
          showToast(jsonBody["msg"].toString());
        } else {
          setState(() {
            product = Product.fromJson(jsonBody["product"]);
            isInWishList = product.isInWishList;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(jsonBody["msg"].toString());
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      showToast(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Product Detail',
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
        actions: [
          cartButton(context, Colors.white),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.appTheme,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  top: 25.0,
                  bottom: 25.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/Path 5244.png',
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),

                        //*PRODUCT IMAGE
                        SizedBox(
                          height: 220,
                          width: MediaQuery.of(context).size.width * 0.56,
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/appTheme.png",
                            image:
                                "${product.thumbnailPath}/${product.thumbnail}",
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.contain,
                            imageErrorBuilder: (_, __, ___) {
                              return Container(
                                height: 220,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/appTheme.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //*PRODUCT WISHLIST BUTTON
                        GestureDetector(
                          onTap: () async {
                            if (mounted) {
                              setState(() {
                                isInWishList = !isInWishList;
                              });
                              await Provider.of<ProductService>(context,
                                      listen: false)
                                  .addProductToWishlist(
                                product.productId,
                                product.variantId,
                              );
                            }
                          },
                          child: isInWishList
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //*PRODUCT NAME
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    //*PRODUCT BRAND NAME
                    Text(
                      'Trust By: ' + product.brandName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (product.categoryId != 11) const SizedBox(height: 10),
                    if (product.categoryId != 11)
                      Text(
                        'By: ' + product.storeName,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹' + product.offerPrice.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '₹' + product.mainPrice.toString(),
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //*PRODUCT RATING & REVIEWS
                    //double.parse(product.rating)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: 4.0,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.yellow.shade900,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          product.reviewCount.toString() + ' Reviews',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // if (product.categoryId != 11)
                    const SizedBox(height: 15),
                    // if (product.categoryId != 11)

                    //ask questions & add to cart button
                    productButtonWidget(),
                    const SizedBox(height: 15),

                    //PRODUCT KEY FEATURES
                    if (product.keyFeatures != null)
                      Text(
                        'Key Feature -',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15.5,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (product.keyFeatures != null) const SizedBox(height: 5),
                    if (product.keyFeatures != null)
                      DescriptionTextWidget(
                        text: product.keyFeatures ?? "",
                      ),
                    const SizedBox(height: 15),

                    //*PRODUCT DESCRIPTION
                    Text(
                      'Description -',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15.5,
                        color: AppColor.appTheme,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    DescriptionTextWidget(
                      text: product.description,
                    ),
                    const SizedBox(height: 15),

                    //product options
                    if (product.categoryId != 11) optionsWidgets(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget optionsWidgets() {
    return Column(
      children: [
        //salt composition
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Salt Composition",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.saltComposition),
              ),
            ),
          ],
        ),
        //product overview
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Products Overview",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.overview),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Usage, Direction and Dosage",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    product.usageDosage,
                  )),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Interactions",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.interactions),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Side Effects",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.sideEffects),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Expert advice and Concern",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.expertAdvice),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "When not to use?",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.notToUse),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "General Instructions & Warnings",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.warning),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0),
          title: Text(
            "Other Details",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(product.otherDetails),
              ),
            ),
          ],
        ),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget productButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //ASK A QUESTION
        GestureDetector(
          onTap: () async {
            if (!await launch(
              'https://wa.me/+91 7697005469',
              forceSafariVC: false,
              forceWebView: false,
              headers: <String, String>{'my_header_key': 'my_header_value'},
            )) {
              throw 'Could not launch ';
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColor.greenColor,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat,
                  size: 20,
                  color: AppColor.whiteColor,
                ),
                Text(
                  'Ask Questions',
                  style: GoogleFonts.nunitoSans(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),

        //ADD TO CART
        if (product.categoryId != 11)
          AddToCartButton(product: product)
        else
          ScheduledYourTestButton(
            product: product,
          ),
      ],
    );
  }
}
