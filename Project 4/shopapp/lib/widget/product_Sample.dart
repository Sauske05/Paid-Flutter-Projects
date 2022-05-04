import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';

import '../screens/product_Detail_Screen.dart';

import '../provider/cart.dart';
import '../provider/auth.dart';

class ProdcutList extends StatelessWidget {
  // final String id;
  // final String imageUrl;
  // final String title;

  // ProdcutList(
  //     {@required this.id, @required this.imageUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    // can put var or final in product.
    // listen false why?
    // product ko listen set to true.
    var product = Provider.of<Product>(
      context,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    final authclass = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routename,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: product.isFav
                ? const Icon(
                    Icons.favorite,
                    color: Colors.deepOrange,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.deepOrange,
                  ),
            onPressed: () {
              product.setlistener(authclass.token, authclass.userID);
            },
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cart.additem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                  'Added a new item to the Cart!',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
                backgroundColor: Colors.black,
              ));
            },
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
