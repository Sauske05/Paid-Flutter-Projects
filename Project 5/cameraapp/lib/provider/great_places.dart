import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/places.dart';
import '../helper/database_sqflite.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newplace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _items.add(newplace);
    notifyListeners();
    DBhelper.insert('places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path
    });
  }
}
