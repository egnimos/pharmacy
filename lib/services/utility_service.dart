import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pharmacy/models/category.dart';
import 'package:pharmacy/models/offer.dart';
import 'package:pharmacy/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/brand.dart';
import '../widgets/toast_widget.dart';

class HomeInfo {
  final String logoPath;
  final String sliderPath;
  final String logoName;
  final String categoryImagePath;

  HomeInfo({
    required this.logoName,
    required this.sliderPath,
    required this.logoPath,
    required this.categoryImagePath,
  });
}

// "appheaders": {
//         "name": "appheader",
//         "logopath": "https://dawadoctor.co.in/public/images/genral",
//         "logo": "Dawan%20doctor%20final%20logo.png",
//         "current_lang": "en",
//         "current_time": "2022-03-11 12:24:27"
//     },

class UtilityService with ChangeNotifier {
  final List<Category> _categories = [];
  final List<Brand> _brands = [];
  final List<Offer> _offers = [];
  final List<Product> _products = [];
  HomeInfo _homeInfo = HomeInfo(
    logoName: "",
    sliderPath: "",
    logoPath: "",
    categoryImagePath: "",
  );

  List<Category> get categories => _categories;
  List<Brand> get brands => _brands;
  List<Offer> get offers => _offers;
  List<Product> get products => _products;
  HomeInfo get homeInfo => _homeInfo;

  Future<void> getHomeInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/homepage?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      // print('------- $model');
      if (response.statusCode == 200) {
        //get the categories
        for (var cat in jsonBody["categories"]["items"]) {
          _categories.add(Category.fromJson(cat));
        }
        //get the brands
        for (var brnd in jsonBody["brands"]) {
          _brands.add(Brand.fromJson(brnd));
        }
        //get the offers
        for (var ofr in jsonBody["sliders"]["items"]) {
          _offers.add(Offer.fromJson(ofr));
        }
        //get the products
        for (var prod in jsonBody["featuredProducts"]) {
          _products.add(Product.fromJson(prod));
        }
        //get the remaning info
        _homeInfo = HomeInfo(
          logoName: jsonBody["appheaders"]["logo"],
          logoPath: jsonBody["appheaders"]["logopath"],
          sliderPath: jsonBody['sliders']['path'],
          categoryImagePath: jsonBody["categories"]["path"],
        );
      } else {
        showToast(jsonBody["msg"].toString());
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }
}
