import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/search.dart';
import 'package:pharmacy/widgets/toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard/product_details_screen.dart';

//**Search inherited []*/
class SearchProd extends SearchDelegate {
  //**construct
  // Search();

  @override
  String get searchFieldLabel {
    return "enter your medicine name";
  }

  //**buildActions
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      //clear the keyword
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  //**buildLeading
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  //**onSearchProvider : this method returns the result based on the switch (which is selected before search) [ISUSER, ISBUCKET, ISPOST]
  Future<List<Search>> searchProd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pinCode = prefs.getString('pin_code');
    final token = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/search/items?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&catid=all&pincode=$pinCode&search=$query',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );
      final jsonBody = json.decode(response.body);
      List<Search> result = [];
      if (response.statusCode == 200) {
        for (var searchInf in jsonBody) {
          result.add(Search.fromJson(searchInf));
        }
      } else {
        showToast(jsonBody["msg"].toString());
      }
      return result;
    } catch (error) {
      showToast(error.toString());
      return <Search>[];
    }
  }

  //**buildResults
  @override
  Widget buildResults(BuildContext context) {
    //pass the query
    return query.isEmpty
        ? const Center(
            child: Text('add your keyword'),
          )
        : FutureBuilder<List<Search>>(
            future: searchProd(),
            builder: (context, snapshot) {
              //waiting
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text('searching.....'),
                );
              }

              //has data
              if (snapshot.hasData) {
                final data = snapshot.data;

                //success final result
                List<Search> result = data ?? [];
                if (result.isEmpty) {
                  return const Center(child: Text('nothing to show'));
                }

                //show product list
                return ListView.builder(
                  itemCount: data!.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(65 / 2),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/appTheme.png",
                            image: data[i].img,
                            height: 35,
                            width: 35,
                            imageErrorBuilder: (_, __, ___) {
                              return Image.asset(
                                "assets/images/appTheme.png",
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              );
                            },
                          ),
                        ),
                        title: Text(
                          data[i].productName,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                id: data[i].id,
                                variantid: 000,
                                from: 'search',
                                data: [],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          );
  }

  //**buildSuggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}

//**searchButton
// Widget searchButton(
//   BuildContext context, {
//   @required Function onPressed,
//   bool isClicked = false,
//   @required String text,
//   @required List<Color> colors,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: Container(
//       margin: const EdgeInsets.symmetric(
//         horizontal: 10.0,
//         vertical: 10.0,
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12.0,
//         vertical: 7.0,
//       ),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         gradient: LinearGradient(
//           colors: colors,
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Row(
//         children: [
//           if (isClicked)
//             Padding(
//               padding: const EdgeInsets.only(right: 5.0),
//               child: Icon(
//                 Icons.check_circle_outline,
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           //text
//           Text(
//             text,
//             style: GoogleFonts.nunitoSans(
//                   color: Colors.grey.shade900,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// //**actions buttons
// class ActionButtons extends StatelessWidget with PreferredSizeWidget {
//   //contruct
//   ActionButtons({Key key, @required this.buttons}) : super(key: key);

//   final List<Widget> buttons;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: buttons,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size(
//         SizeConfig.widthMultiplier * 100.0,
//         SizeConfig.heightMultiplier * 8.0,
//       );
// }