import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/address.dart' as address;
import '../widgets/toast_widget.dart';

enum AddressType {
  city,
  state,
  country,
  unknow,
}

class AddressService with ChangeNotifier {
  List<address.State> _states = [];
  List<address.Country> _countries = [];
  List _searchResults = [];
  List<address.City> _cities = [];
  List<address.Address> _addresses = [];

  List<address.State> get states => _states;
  List<address.Country> get countries => _countries;
  List<address.City> get cities => _cities;
  List<address.Address> get addresses => _addresses;
  List get searchResults => _searchResults;

  void clearSearchResult() {
    _searchResults.clear();
    notifyListeners();
  }

  void getSearchListBasedOnInput(
    String value, {
    AddressType type = AddressType.unknow,
  }) {
    //return if value is empty
    if (value.isEmpty) {
      clearSearchResult();
      return;
    }

    final result = () {
      if (type == AddressType.city) {
        return _cities
            .where(
                (city) => city.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }

      if (type == AddressType.state) {
        return _states
            .where((state) =>
                state.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }

      return [];
    }();

    //update with new value
    _searchResults = result;
    notifyListeners();
  }

  //get the list of state
  Future<void> getStateList(int countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
            "https://dawadoctor.co.in/public/api/states/$countryId?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR"),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);

      List<address.State> result = [];
      if (jsonBody["status"] == 'fail') {
        showToast("failed to load the data");
      } else {
        final List statesList = jsonBody['states'];
        for (Map<String, dynamic> state in statesList) {
          result.add(address.State.fromJson(state));
        }

        _states = result;
      }
      notifyListeners();
    } catch (error) {
      print("error $error");
      showToast(error.toString());
    }
  }

  //get the list of country
  Future<void> geCountryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
            "https://dawadoctor.co.in/public/api/countries?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR"),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final jsonBody = json.decode(response.body);
      print('countries $jsonBody');
      List<address.Country> result = [];
      if (jsonBody["status"] == 'success') {
        final List countryList = jsonBody['countries'];
        for (Map<String, dynamic> country in countryList) {
          result.add(address.Country.fromJson(country));
        }

        _countries = result;
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }

  //get the list of the cities
  Future<void> getCityList(int stateId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      final response = await http.get(
        Uri.parse(
            "https://dawadoctor.co.in/public/api/city/$stateId?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR"),
        headers: {
          'Authorization': 'Bearer $auth',
        },
      );
      final model = json.decode(response.body);
      List<address.City> result = [];
      if (model["status"] == 'fail') {
        showToast("failed to load the data");
      } else {
        final citiesList = model['cities'];
        for (Map<String, dynamic> city in citiesList) {
          result.add(address.City.fromJson(city));
        }
        _cities = result;
      }
      notifyListeners();
    } catch (error) {
      // //print("error");
      showToast(error.toString());
    }
  }

  Future<void> getAddressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    // print("auth::::: $auth");
    try {
      final response = await http.get(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/manageaddress?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        headers: {'Authorization': 'Bearer $auth'},
      );
      final jsonBody = json.decode(response.body);
      List<address.Address> result = [];
      print('sdfjdsfl $jsonBody');
      if (response.statusCode == 200) {
        if (jsonBody["status"] == 'success') {
          for (var addr in jsonBody['address']) {
            result.add(address.Address.fromJson(addr));
          }
          _addresses = result;
        } else {
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

  //save the address
  Future<void> addAddress(
      BuildContext context, String from, address.Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    const url1 = 'https://dawadoctor.co.in/public/api/create-address';
    // const url2 = 'https://dawadoctor.co.in/public/api/create-billing-address';
    try {
      final response = await http.post(
        Uri.parse(
          url1,
        ),
        headers: {'Authorization': 'Bearer $auth'},
        body: address.toJson(),
      );
      final model = json.decode(response.body);
      if (response.statusCode == 200) {
        if (model["status"] == 'success') {
          showToast(model["msg"].toString());
          _addresses.add(address);

          Navigator.pop(context, true);
        } else {
          showToast(model["msg"].toString());
        }
      } else {
        showToast(model["msg"].toString());
      }
      notifyListeners();
    } catch (error) {
      showToast(error.toString());
    }
  }
}
