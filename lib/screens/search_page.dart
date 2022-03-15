// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pharmacy/constants/input_form_field.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import '../theme/color_theme.dart';
// import '../widgets/toast_widget.dart';
// import 'Dashboard/product_details_screen.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();
//   bool isLoading1 = false;
//   List history = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColor.appTheme,
//         title: Text(
//           'Search for products, brands & category',
//           style: GoogleFonts.nunitoSans(
//             fontSize: 18,
//             color: AppColor.whiteColor,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             children: [
//               isLoading1
//                   ? const LinearProgressIndicator()
//                   : const SizedBox.shrink(),
//               SizedBox(
//                 height: 85,
//                 child: AllInputDesign(
//                   controller: searchController,
//                   hintText: 'Search',
//                   autofocused: true,
//                   suffixIcon: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.search),
//                   ),
//                   // onChanged: (val) => getSearchData(),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(width: 0, color: Color(0xfff0f0f0)),
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(width: 0, color: Color(0xfff0f0f0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(width: 0, color: Color(0xfff0f0f0)),
//                   ),
//                   inputborder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(width: 0, color: Color(0xfff0f0f0)),
//                   ),
//                 ),
//               ),
//               for (int i = 0; i < history.length; i++) ...[
//                 SizedBox(
//                   height: 80,
//                   width: MediaQuery.of(context).size.width,
//                   child: ListTile(
//                     leading: Image.network(
//                       history[i]['img'] ?? '',
//                       height: 25,
//                       width: 25,
//                     ),
//                     title: Text(
//                       history[i]['value'] ?? '',
//                     ),
//                     onTap: () {
//                       if (history[i]['value'] != 'No Result found') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetailScreen(
//                               id: history[i]['id'],
//                               variantid: 000,
//                               from: 'search',
//                               data: [],
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 const Divider(),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
