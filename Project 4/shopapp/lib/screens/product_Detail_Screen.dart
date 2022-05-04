import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

import '../provider/products.dart';

import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routename = './Product_Detail_Screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;

    // if loadedProdct is not final it creates error.. Why??  // Can't use var on loadedProduct

    // seeting listen to false will not cause this widget to rebuid, even if changes are made to the Products list//
    //  Provider.of<Products>(context, listen : false) => can be set like this.

    // Provider.of<Products>(ctx, listen : true).items => List<Product>
    final listproduct = Provider.of<Products>(context, listen: true).items;
    // print(listproduct);

    final loadedProduct = Provider.of<Products>(
      context,
    ).items.firstWhere(
      (element) {
        return element.id == productId;
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
    );
  }
}
