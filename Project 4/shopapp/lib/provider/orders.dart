import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import './cart.dart';

// More detail in order screen. Check the init state.
class OrderItem {
  final String id;
  final double amount;
  final DateTime date;
  final List<CartItem> products;

  OrderItem({this.id, this.amount, this.date, this.products});
}

class Order with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }

  final String authtoken;
  Order(this.authtoken, this._order);

  Future<void> fetchandsave() async {
    var url = Uri.parse(
        'https://flutter-1906c-default-rtdb.firebaseio.com/orders.json?auth=$authtoken');

    final response = await http.get(url);
    // .body can be accesed after async await.
    print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<OrderItem> _Loadedorderitem = [];
    extractedData.forEach((key, value) {
      _Loadedorderitem.add(OrderItem(
          id: key,
          amount: double.parse(value['amount']),
          date: value[DateTime.parse(value['date'])],
          // error here.
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  price: e['price'],
                  quantity: e['quantity'],
                  title: e['title']))
              .toList()));
    });
    _order = _Loadedorderitem;
    notifyListeners();
  }

  Future<void> addorder(List<CartItem> cartproduts, double total) async {
    var url = Uri.parse(
        'https://flutter-1906c-default-rtdb.firebaseio.com/orders.json?auth=$authtoken');
    final dateval = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total.toString(),
          'date': dateval.toIso8601String(),
          'products': [
            {
              cartproduts
                  .map((e) => {
                        'id': e.id.toString(),
                        'title': e.title,
                        'quantity': e.quantity.toString(),
                        'price': e.price.toString()
                      })
                  .toList(),
            }
            // json need everything to be converted into string.
          ].toString(),
        }));
    // check this.

    _order.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            date: dateval,
            products: cartproduts,
            amount: total));

    notifyListeners();
  }

  void removelist() {
    _order = [];
    notifyListeners();
  }
}
