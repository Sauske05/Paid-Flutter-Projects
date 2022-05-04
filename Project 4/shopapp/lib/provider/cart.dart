import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemcount {
    if (_items.length == null) {
      return 0;
    } else {
      return _items.length;
    }
  }

  double get totalamount {
    double total = 0;
    _items.forEach((key, value) {
      total = total + (value.price * value.quantity);
    });

    return total;
  }

  //Product ID is the key....

  void additem(String productID, double price, String title) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1,
              title: value.title));
      //.....
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
    }
    notifyListeners();
  }

// getting rid of an entry in a Map.
  void removeitem(String productID) {
    /// not from items but from _items. Observe the difference.
    _items.remove(productID);
    notifyListeners();
  }

  void removeSingleItem(String productID) {
    if (!_items.containsKey(productID)) {
      return;
    }

    if (_items[productID].quantity > 1) {
      _items.update(
          productID,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quantity: value.quantity - 1,
              title: value.title));
    } else {
      _items.remove(productID);
    }

    notifyListeners();
  }

  void clearcart() {
    _items = {};
    notifyListeners();
  }
}
