import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/screens/search_page.dart';
import 'package:pharmacy/screens/search_screen.dart';
import 'package:pharmacy/services/category_service.dart';
import 'package:pharmacy/widgets/products_list_widget.dart';
import 'package:provider/provider.dart';

import '../../theme/color_theme.dart';

class ViewCategoryProducts extends StatefulWidget {
  final int catId;
  final String heading;
  const ViewCategoryProducts({
    Key? key,
    required this.catId,
    required this.heading,
  }) : super(key: key);
  @override
  _ViewCategoryProductsState createState() => _ViewCategoryProductsState();
}

class _ViewCategoryProductsState extends State<ViewCategoryProducts> {
  bool isLoading = false;
  bool isAddToCart = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      loadInfo();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void loadInfo() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await Provider.of<CategoryService>(context, listen: false)
        .getCategoryProducts(widget.catId);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<CategoryService>(context).categoryProducts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: Text(
          widget.heading,
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProd(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: AppColor.whiteColor,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productList.isEmpty
              ? const Center(
                  child: Text('No Data Found'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: ListView(
                    children: [
                      ProductsWidget(
                        heading: "Products",
                        products: productList,
                      ),
                    ],
                  ),
                ),
    );
  }
}

  // SingleChildScrollView(
  //       child: SizedBox(
  //         height: MediaQuery.of(context).size.height,
  //         child: isLoading
  //             ? const Center(
  //                 child: CircularProgressIndicator(),
  //               )
  //             : products.isEmpty
  //                 ? const Center(
  //                     child: Text('No Data Found'),
  //                   )
  //                 : Stack(
  //                     alignment: Alignment.topCenter,
  //                     children: [
  //                       ListView.builder(
  //                           shrinkWrap: true,
  //                           scrollDirection: Axis.vertical,
  //                           padding: const EdgeInsets.only(
  //                               left: 25, right: 25, bottom: 120),
  //                           itemCount: products.length,
  //                           itemBuilder: (context, i) {
  //                             // var id = mSlidesModel[i]['id'];
  //                             // var proid = mSlidesModel[i]['productid'];

  //                             // ignore: prefer_typing_uninitialized_variables
  //                             // var pName;
  //                             // if (mSlidesModel[i]['productname'] == null) {
  //                             //   pName = mSlidesModel[i]['product_name']['en'];
  //                             // } else {
  //                             //   pName = mSlidesModel[i]['productname']['en'];
  //                             // }
  //                             // var discount = ((mSlidesModel[i]['price'] -
  //                             //             mSlidesModel[i]['offer_price']) /
  //                             //         mSlidesModel[i]['price']) *
  //                             //     100;
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                     builder: (context) => ProductDetailScreen(
  //                                       id: id ?? proid,
  //                                       variantid:
  //                                           mSlidesModel[i]['variantid'] ?? 000,
  //                                       from: 'category',
  //                                       data: [],
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                               child: Container(
  //                                 decoration: BoxDecoration(
  //                                   color: AppColor.whiteColor,
  //                                   border: Border.all(color: Colors.grey),
  //                                   borderRadius: BorderRadius.circular(10),
  //                                 ),
  //                                 margin: const EdgeInsets.only(top: 10),
  //                                 child: Row(
  //                                   children: [
  //                                     Container(
  //                                       height: 120,
  //                                       width: 100,
  //                                       padding: const EdgeInsets.only(
  //                                           left: 5, top: 2, bottom: 2),
  //                                       child: Image.network(
  //                                         mSlidesModel[i]['thumbpath'] == null
  //                                             ? 'https://dawadoctor.co.in/images/simple_products/' +
  //                                                 mSlidesModel[i]['thumbnail']
  //                                             : '${mSlidesModel[i]['thumbpath']}/${mSlidesModel[i]['images']}',
  //                                         fit: BoxFit.fill,
  //                                       ),
  //                                     ),
  //                                     const SizedBox(width: 10),
  //                                     Expanded(
  //                                       child: Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.start,
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Row(
  //                                             children: [
  //                                               Expanded(
  //                                                 child: Text(
  //                                                   pName,
  //                                                   maxLines: 2,
  //                                                   style:
  //                                                       GoogleFonts.nunitoSans(
  //                                                     fontSize: 15,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     color: AppColor.fontColor,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               IconButton(
  //                                                 onPressed: () {},
  //                                                 icon: const Icon(
  //                                                   Icons.favorite_border,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           const SizedBox(height: 5),
  //                                           Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               Column(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.start,
  //                                                 children: [
  //                                                   Text(
  //                                                     mSlidesModel[i][
  //                                                                 'offer_price'] ==
  //                                                             null
  //                                                         ? '₹' +
  //                                                             mSlidesModel[i][
  //                                                                     'offerprice']
  //                                                                 .toString()
  //                                                         : '₹' +
  //                                                             mSlidesModel[i][
  //                                                                     'offer_price']
  //                                                                 .toString(),
  //                                                     maxLines: 2,
  //                                                     style: GoogleFonts
  //                                                         .nunitoSans(
  //                                                       fontSize: 14,
  //                                                       color:
  //                                                           AppColor.fontColor,
  //                                                       fontWeight:
  //                                                           FontWeight.bold,
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                               const SizedBox(width: 8),
  //                                               Text(
  //                                                 mSlidesModel[i]
  //                                                             ['mainprice'] ==
  //                                                         null
  //                                                     ? '₹' +
  //                                                         mSlidesModel[i]
  //                                                                 ['price']
  //                                                             .toString()
  //                                                     : '₹' +
  //                                                         mSlidesModel[i]
  //                                                                 ['mainprice']
  //                                                             .toString(),
  //                                                 maxLines: 2,
  //                                                 style: GoogleFonts.nunitoSans(
  //                                                   fontSize: 14,
  //                                                   color: Colors.grey,
  //                                                   decoration: TextDecoration
  //                                                       .lineThrough,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                           Row(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment
  //                                                     .spaceBetween,
  //                                             children: [
  //                                               Text(
  //                                                 '${discount.toStringAsFixed(2)}% OFF',
  //                                                 maxLines: 2,
  //                                                 style: GoogleFonts.nunitoSans(
  //                                                   fontSize: 13.5,
  //                                                   fontWeight: FontWeight.bold,
  //                                                   color: AppColor.appTheme,
  //                                                 ),
  //                                               ),
  //                                               Align(
  //                                                 alignment:
  //                                                     Alignment.bottomRight,
  //                                                 child: GestureDetector(
  //                                                   onTap: () {
  //                                                     addCart(
  //                                                       mSlidesModel[i]
  //                                                           ['variantid'],
  //                                                       mSlidesModel[i]
  //                                                               ['productid'] ??
  //                                                           mSlidesModel[i]
  //                                                               ['id'],
  //                                                       1,
  //                                                     );
  //                                                   },
  //                                                   child: Container(
  //                                                     height: 35,
  //                                                     width: 70,
  //                                                     margin:
  //                                                         const EdgeInsets.only(
  //                                                             right: 10,
  //                                                             bottom: 8),
  //                                                     decoration: BoxDecoration(
  //                                                       borderRadius:
  //                                                           BorderRadius
  //                                                               .circular(45),
  //                                                       color:
  //                                                           AppColor.whiteColor,
  //                                                       border: Border.all(
  //                                                         color:
  //                                                             AppColor.appTheme,
  //                                                         width: 1.5,
  //                                                       ),
  //                                                     ),
  //                                                     alignment:
  //                                                         Alignment.center,
  //                                                     child: Text(
  //                                                       'Add',
  //                                                       style: GoogleFonts
  //                                                           .nunitoSans(
  //                                                         color:
  //                                                             AppColor.appTheme,
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           }),
  //                       isAddToCart
  //                           ? const Padding(
  //                               padding: EdgeInsets.only(top: 15.0),
  //                               child: CircularProgressIndicator(),
  //                             )
  //                           : const SizedBox.shrink()
  //                     ],
  //                   ),
  //       ),
  //     ),

//   Future<void> addCart(varientid, int proId, quantity) async {
//     setState(() {
//       isAddToCart = true;
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var auth = prefs.getString('access_token');
//     String varID = varientid == null ? '0' : varientid.toString();
//     try {
//       var headers = {
//         'Authorization': 'Bearer ${auth ?? USERTOKEN}',
//         'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
//       };
//       var request = http.MultipartRequest(
//           'POST', Uri.parse('https://dawadoctor.co.in/public/api/addtocart'));
//       request.fields.addAll({
//         'currency': 'INR',
//         'variantid': varID,
//         'quantity': quantity.toString(),
//         'pro_id': proId.toString()
//       });

//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         setState(() {
//           isAddToCart = false;
//           CARTCOUNT = CARTCOUNT + 1;
//         });

//         print('response get ' + await response.stream.bytesToString());

//         showToast("Product Added into cart");
//       } else {
//         setState(() {
//           isAddToCart = false;
//         });
//       }
//     } catch (error) {
//       print('/////// ' + error.toString());
//       setState(() {
//         isAddToCart = false;
//       });
//       // progressHUD.state.dismiss();
//       showToast(error.toString());
//     }
//   }
// }

