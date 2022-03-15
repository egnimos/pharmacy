import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/toast_widget.dart';

class UserService with ChangeNotifier {
  User _user = User(
    email: "",
    mobile: "",
    age: "",
    bloodGroup: "",
    gender: "",
    height: "",
    name: "",
    weight: "",
    image: "",
    referCode: "",
  );

  User get user => _user;

  //update the user
  Future<void> updateUser(User user, File? file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final headers = {'Authorization': 'Bearer $auth'};

      final request = http.MultipartRequest(
        "Post",
        Uri.parse(
          'https://dawadoctor.co.in/public/api/update_profile',
        ),
      );
      //add the header
      request.headers.addAll(headers);
      //add the request body
      request.fields.addAll(user.toJson());
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.path,
          ),
        );
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        _user = user;
        showToast('profile has been updated');
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //get the user
  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      // print('------- $model');
      if (response.statusCode == 200) {
        if (jsonBody["status"] == 'fail') {
          showToast(jsonBody["msg"].toString());
        } else {
          _user = User.fromJson(jsonBody);
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
