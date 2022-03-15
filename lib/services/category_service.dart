import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pharmacy/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/toast_widget.dart';

class CategoryService with ChangeNotifier {
  List<Category> _categories = [];
  List<Product> _categoryProducts = [];

  List<Category> get categories => _categories;
  List<Product> get categoryProducts => _categoryProducts;

  //get the categories
  Future<void> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    const uri =
        "https://dawadoctor.kiashinfotech.com/public/api/categories?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR";
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      List<Category> result = [];
      if (response.statusCode == 200) {
        for (var cat in jsonBody["categories"]) {
          result.add(Category.fromJson(cat));
        }
        _categories = result;
      } else {
        showToast("failed to load the data");
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //get the category based products
  Future<void> getCategoryProducts(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    final uri =
        "https://dawadoctor.co.in/public/api/category/$id?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR";
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
          result.add(Product.fromJson(
            prod,
            isDisabled: true,
          ));
        }
        _categoryProducts = result;
      } else {
        showToast("failed to load the data");
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }
}
