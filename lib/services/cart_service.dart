import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pharmacy/models/cart.dart';
import 'package:pharmacy/widgets/toast_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class CartService with ChangeNotifier {
  List<CartProduct> _cartProducts = [];
  CartInfo _cartInf = CartInfo(
    subTotal: 0.toString(),
    shipping: 0,
    couponDiscount: 0,
    grandTotal: 0,
    currency: "",
    symbol: "",
    appliedCoupon: "",
    offers: "",
  );

  CartInfo get cartInf => _cartInf;
  List<CartProduct> get cartProducts => _cartProducts;

  //get the cart
  Future<void> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/cart?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {'Authorization': 'Bearer  ${auth ?? USERTOKEN}'},
      );
      final jsonBody = json.decode(response.body);

      //check for the response
      if (response.statusCode == 200) {
        if (jsonBody["status"] == 'fail') {
          showToast(jsonBody["msg"].toString());
        } else {
          List<CartProduct> results = [];
          final List jsonList = jsonBody["products"] ?? [];
          for (var cartProd in jsonList) {
            results.add(CartProduct.fromJson(cartProd));
          }
          //get remaining cart info
          _cartInf = CartInfo.fromJson(jsonBody);
          _cartProducts = results;
        }
      } else {
        showToast(jsonBody["msg"].toString());
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //add it to the cart
  Future<void> addProductToCart(CartProduct cartProd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    const uri = 'https://dawadoctor.co.in/public/api/addtocart';
    try {
      final headers = {
        'Authorization': 'Bearer ${auth ?? USERTOKEN}',
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
      };
      final response = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: {
          "currency": cartProd.currency,
          "variantid": cartProd.variantId.toString(),
          "quantity": cartProd.quantity.toString(),
          "pro_id": cartProd.productId.toString(),
        },
      );

      final jsonBody = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonBody["status"] == "fail") {
          showToast(jsonBody["msg"].toString());
        } else {
          _cartProducts.add(cartProd);
          showToast("product is added to the card");
        }
      } else {
        showToast("failed to save the product in the cart");
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //change slider data
  Future<void> changeProductQuantity({
    required int cartId,
    required int variantid,
    required int qty,
    required int initialQty,
    required double subTotal,
    required double initialSubTotal,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      //update cart quantity in cache
      changeProductQuantityFromCache(
        cartId,
        qty,
        subTotal,
        initialSubTotal,
      );
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/increase-quantity/in/cart?cartid=$cartId&variantid=$variantid&currency=INR&quantity=$qty&secret=secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: {'Authorization': 'Bearer ${auth ?? USERTOKEN}'},
        body: {
          'cartId': cartId.toString(),
          'variantid': variantid.toString(),
          'quantity': qty.toString()
        },
      );
      // print('response gghh-- ${response.body}');

      final jsonBody = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonBody["status"] == 'fail') {
          //failed to update the product quantity.. rewinding it to the intial value in cache
          changeProductQuantityFromCache(
            cartId,
            initialQty,
            subTotal,
            initialSubTotal,
            isFailed: true,
          );
          showToast(jsonBody["msg"].toString());
        } else {}
      } else {
        showToast(jsonBody["msg"].toString());
      }
      // notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  void changeProductQuantityFromCache(
    int cartId,
    int qty,
    double subTotal,
    double initialSubTotal, {
    bool isFailed = false,
  }) {
    for (var prodInf in _cartProducts) {
      if (prodInf.cartId == cartId) {
        prodInf.quantity = qty;
      }
    }
    //check if request is failed then return to initial value
    if (isFailed) {
      _cartInf.subTotal = initialSubTotal.toStringAsFixed(2);
      _cartInf.grandTotal = double.parse(_cartInf.subTotal);
    } else {
      _cartInf.subTotal = subTotal.toStringAsFixed(2);
      _cartInf.grandTotal = double.parse(_cartInf.subTotal);
    }
    notifyListeners();
  }

  Future<void> removeCartProduct(
      CartProduct cartProd, double initialSubTotal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final cartProdIndex =
          _cartProducts.indexWhere((prod) => prod.cartId == cartProd.cartId);
      //remove the cart prod from cache
      removeCartProductFromCache(
        cartProd,
        cartProdIndex,
        initialSubTotal,
      );
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/remove/cart/item?cartid=${cartProd.cartId}&currency=INR&secret=secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: {'Authorization': 'Bearer ${auth ?? USERTOKEN}'},
      );
      final model = json.decode(response.body);
      if (response.statusCode == 200) {
        if (model["status"] == 'fail') {
          removeCartProductFromCache(
            cartProd,
            cartProdIndex,
            initialSubTotal,
            isFailed: true,
          );
          showToast(model["msg"].toString());
        } else {}
      } else {
        showToast(model["msg"].toString());
      }
    } catch (error) {
      showToast(error.toString());
    }
  }

  void removeCartProductFromCache(
    CartProduct cart,
    int index,
    double initialSubTotal, {
    bool isFailed = false,
  }) {
    //check if the request is failed
    if (isFailed) {
      _cartProducts.insert(
        index,
        cart,
      );
      //update the sub total value
      _cartInf.subTotal = initialSubTotal.toString();
      _cartInf.grandTotal = double.parse(_cartInf.subTotal);
    } else {
      _cartProducts.removeAt(index);
      //check the quantity of the cart and update the subtotal
      final totalProductPrice =
          double.parse(cart.originalOfferPrice) * cart.quantity;
      final subTotal = initialSubTotal - totalProductPrice;
      _cartInf.subTotal = subTotal.toStringAsFixed(2);
      _cartInf.grandTotal = double.parse(_cartInf.subTotal);
    }
    notifyListeners();
  }

  //clear cart
  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/clear-cart?currency=INR&secret=secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: {'Authorization': 'Bearer ${auth ?? USERTOKEN}'},
      );
      final jsonBody = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonBody["status"] == 'fail') {
          showToast(jsonBody["msg"].toString());
        } else {
          _cartProducts.clear();
          //clear the cart
          _cartInf = CartInfo(
            subTotal: 0.toString(),
            shipping: 0,
            couponDiscount: 0,
            grandTotal: 0.0,
            currency: "",
            symbol: "",
            appliedCoupon: "",
            offers: "",
          );
          showToast(jsonBody["msg"].toString());
        }
      } else {
        showToast(jsonBody["msg"].toString());
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }
}
