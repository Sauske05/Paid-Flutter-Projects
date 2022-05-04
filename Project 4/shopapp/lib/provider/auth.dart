import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  // DateTime _expirydate;
  String _userId;
// reminder: dart:convert for json.decode.

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get userID {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAl0myZhGLm0OxxaQQby9NRny4nI5IW3rY');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      var responseData = json.decode(response.body);
      print(responseData);
      // if (responseData['error'] = !null) {
      //   return HttpException(responseData['error']['message']);
      // }
      // // understand this!
      // // check this if error occurs!

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      // _expirydate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {}
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAl0myZhGLm0OxxaQQby9NRny4nI5IW3rY');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(response.body);
      var responseData = json.decode(response.body);
      print(responseData);
      // if (responseData['error'] = !null) {
      //   return HttpException(responseData['error']['message']);
      // }
      // // understand this!
      // // check this if error occurs!
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      // _expirydate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {}
  }
}
