import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import './product_Sample.dart';

class Product_Grid extends StatelessWidget {
  final bool isFav;
  Product_Grid(this.isFav);
  @override
  Widget build(BuildContext context) {
    // var changed into final.
    final productsData = Provider.of<Products>(context);
    // print(productsData.items);
    // print(isFav);
    // print(productsData.favsonly);

    final loadedproduct = isFav ? productsData.favsonly : productsData.items;
    // print(loadedproduct);
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5 / 3,
          mainAxisSpacing: 15.00,
          crossAxisSpacing: 15.00),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
            value: loadedproduct[index],
            child: ProdcutList(
                // id: loadedproduct[index].id,
                // imageUrl: loadedproduct[index].imageUrl,
                // title: loadedproduct[index].title,
                ));
      },
      itemCount: loadedproduct.length,
    );
  }
}
