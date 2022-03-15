import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pharmacy/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/models/brand.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/toast_widget.dart';

class BrandService with ChangeNotifier {
    List<Brand> _brands = [];
  List<Product> _brandProducts = [];

  List<Brand> get brands => _brands;
  List<Product> get brandProducts => _brandProducts;

  //get the brands
  Future<void> getBrands() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    const uri =
        "https://dawadoctor.kiashinfotech.com/public/api/brands?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR";
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      List<Brand> result = [];
      if (response.statusCode == 200) {
        for (var brand in jsonBody) {
          result.add(Brand.fromJson(brand));
        }
        _brands = result;
      } else {
        showToast("failed to load the data");
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //get the brand based products
  Future<void> getBrandProducts(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    final uri =
        "https://dawadoctor.co.in/public/api/brands/$id/products?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR";
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      List<Product> result = [];
      if (response.statusCode == 200) {
        for (var prod in jsonBody["products"]) {
          result.add(Product.fromJson(prod));
        }
        _brandProducts = result;
      } else {
        showToast("failed to load the data");
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }
}