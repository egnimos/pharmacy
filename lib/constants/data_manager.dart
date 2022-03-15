import 'package:flutter/cupertino.dart';

class DataManager {
  var _userId,_userName,_userSurname,_userToken;
  var _usercontact;
  var _userEmail;
  var _userAdd;
  var _baseUrl;
  var _country;

  static final DataManager ourInstance = DataManager();

  static DataManager getInstance() {
    return ourInstance;
  }

  String userId() {
    return _userId;
  }

  setUserId(value) {
    _userId = value;
  }

  String userToken() {
    return _userToken;
  }

  setUserToken(value) {
    _userToken = value;
  }

  String userName() {
    return _userName;
  }

  setUserName(value) {
    _userName = value;
  }

  String userSName() {
    return _userSurname;
  }

  setUserSName(value) {
    _userSurname = value;
  }

  String userContact() {
    return _usercontact;
  }

  setuserContact(value) {
    _usercontact = value;
  }

  String userEmail() {
    return _userEmail;
  }

  setuserEmail(value) {
    _userEmail = value;
  }

  String userAdd() {
    return _userAdd;
  }

  setuserAdd(value) {
    _userAdd = value;
  }

  String baseUrl() {
    return _baseUrl;
  }

  setBaseUrl(value) {
    _baseUrl = value;
  }

  String countryName() {
    return _country;
  }

  setCountryName(value) {
    _country = value;
  }
}
