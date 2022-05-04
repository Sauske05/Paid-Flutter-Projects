import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String userId;
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  bool isFav;
  final double price;

  Product(
      {@required this.userId,
      @required this.id,
      @required this.description,
      @required this.imageUrl,
      @required this.title,
      @required this.price,
      @required this.isFav});

  void setlistener(String token, String userID) async {
    final oldisFav = isFav;
    isFav = !isFav;
    notifyListeners();
    // incase notify listener doesnt work put it here!
    var url = Uri.parse(
        // check products.dart where u add the loadedproducts from fetch and save.
        'https://flutter-1906c-default-rtdb.firebaseio.com/userFav/$userID/$id.json?auth=$token');
    try {
      await http.put(url, body: json.encode(isFav));
      notifyListeners();
    } catch (error) {
      isFav = oldisFav;
      notifyListeners();
    }

    // notifyListeners();
  }
}
