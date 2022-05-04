import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  /// observe this...
  List<Product> get items {
    // if (_showFavouritesonly = false) {
    //   return _items.where((element) => element.isFav).toList();
    // }
    return [..._items];
  }

  final String authtoken;
  final String userID;
  Products(this.authtoken, this._items, this.userID);

  List<Product> get favsonly {
    return _items.where((element) => element.isFav).toList();
  }

  Product findbyID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchandsave([bool filterbyuser = false]) async {
    final filterstring =
        filterbyuser ? 'orderBy="creatorID"&equalto="$userID"' : '';
    var url = Uri.parse(

        /// filtering for specific users. Unique to firebase.
        'https://flutter-1906c-default-rtdb.firebaseio.com/products.json?auth=$authtoken&$filterstring');
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      print('HEllo There');
      // if this doesnt work change Map<String , Object> to dynamic.

      // MAp<String, Object> doesnt work lol.
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://flutter-1906c-default-rtdb.firebaseio.com/userFav/$userID.json?auth=$authtoken');
      final favouriteresponse = await http.get(url);
      print(favouriteresponse.body);
      // body comes after we add await in the get url.
      final favouritedata =
          json.decode(favouriteresponse.body) as Map<String, dynamic>;
      final List<Product> loadedproduct = [];

      extractedData.forEach((key, value) {
        loadedproduct.add(Product(
          userId: userID,
          // check authtoken.
          // there is alternatice at lecture 271.
          id: key,
          title: value['title'],
          description: value['description'],
// checck this.
// this was the error bro! // favouritedata[value][value]
          isFav: favouritedata == null
              ? false
              : favouritedata[value[value]] ??
                  false, //?? only executes if favouritedata[key] is null.
          price: value['price'],
          imageUrl: value['imageUrl'],
        ));
      });
      _items = loadedproduct;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addproducts(Product product) {
    var url = Uri.parse(
        'https://flutter-1906c-default-rtdb.firebaseio.com/products.json?auth=$authtoken');
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'creatorID': userID
            }))
        .then((value) {
      print(value);
      // response has a body. so the json decode converts it into some data we can read.
      print(json.decode(value.body));
      final newproduct = Product(
        title: product.title,
        imageUrl: product.imageUrl,
        //try with datetime.now() once as well.
        id: json.decode(value.body)['name'],
        description: product.description,
        price: product.price,
      );
      _items.add(newproduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  void deleteproducts(String id) {
    print(id);

    var url = Uri.parse(
        'https://flutter-1906c-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken');
    final existingproductIndex =
        _items.indexWhere((element) => element.id == id);
    print(_items);
    var existingproduct = _items[existingproductIndex];
    _items.removeAt(existingproductIndex);
    notifyListeners();

    http.delete(url).then((value) {
      // why this?
      // clear up that object cause no one is interested in this object anymore.
      existingproduct = null;
    }).catchError((error) {
      _items.insert(existingproductIndex, existingproduct);
      notifyListeners();
    });

    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product newproduct) async {
    //check this.
    // this check is some where esle as well. check it.
    print('Hello there $id');
    final prodindex = _items.indexWhere((element) => element.id == id);

    if (prodindex >= 0) {
      var url = Uri.parse(
          'https://flutter-1906c-default-rtdb.firebaseio.com/products/$id.json?auth=$authtoken');

      // http.patch updates the data.
      await http.patch(url,
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'price': newproduct.price,
            'imageUrl': newproduct.imageUrl,
          }));
      _items[prodindex] = newproduct;
      notifyListeners();
    } else {
      print('object................');
    }
  }
}

// notify lisner is super important. check once without notify listner.
  // void showfavouritesonly() {
  //   _showFavouritesonly = true;
  //   notifyListeners();
  // }

//   void showAll() {
//     _showFavouritesonly = false;
//     notifyListeners();
//   }


// }

//
// }

