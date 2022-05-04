import 'package:flutter/material.dart';
import 'package:shopapp/provider/products.dart';

import '../screens/edit_User_Product.dart';
import 'package:provider/provider.dart';

class UserProducts extends StatelessWidget {
  final String id;
  final String imageurl;
  final String title;

  UserProducts(
      {@required this.id, @required this.imageurl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditUserProduct.route, arguments: id);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteproducts(id);
              },
              icon: const Icon(Icons.delete))
        ]),
      ),
    );
  }
}
