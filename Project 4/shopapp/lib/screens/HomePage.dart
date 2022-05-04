import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../widget/app_drawer.dart';

import '../provider/cart.dart';
import '../widget/badge.dart';

import '../widget/Product_Grid.dart';
import './cart_screen.dart';

import '../provider/products.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isFav = false;

  @override
  void initState() {
    // listen false why?
    Future.delayed(
      Duration(seconds: 0),
    ).then((value) =>
        Provider.of<Products>(context, listen: false).fetchandsave());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartclass = Provider.of<Cart>(context);
    // var Productclass = Provider.of<Products>(context, listen:false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          PopupMenuButton(
            // putting set state causes error!
            onSelected: (int value) {
              setState(() {
                if (value == 0) {
                  _isFav = true;
                } else {
                  _isFav = false;
                }
              });
            },
            // onSelected: ((value) => cartclass.onselect(value)),
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text('Favourites'),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text('All Items'),
                  value: 1,
                )
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
          Badge(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, CartScreen.route),
              ),
              value: cartclass.itemcount.toString())
        ],
      ),
      body: Container(
        child: Product_Grid(_isFav),
      ),
    );
  }
}
