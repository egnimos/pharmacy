import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy/widgets/toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductService with ChangeNotifier {
  //add product to whishlist
  Future<bool> addProductToWishlist(id, vrId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/wishlist/add?currency=INR&secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14%27',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
        body: {
          'variantid': vrId.toString(),
          'simple_pro_id': id.toString(),
          'collection_id': '1',
        },
      );
      final jsonBody = json.decode(response.body);
      // print('aass wish $model');
      if (response.statusCode == 200) {
        if (jsonBody['status'] == 'success') {
          showToast(jsonBody['msg']);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      showToast(error.toString());
      return false;
    }
  }
}
