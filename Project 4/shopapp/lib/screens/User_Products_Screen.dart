import 'package:flutter/material.dart';

import '../provider/products.dart';

import 'package:provider/provider.dart';
import '../widget/User_Product.dart';
import './edit_User_Product.dart';
import '../widget/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const route = './UserProductsScreen';

  Future<void> onRefresh(BuildContext context) async {
    //listen should be false. we just want  to trigget the fucntion fetch and save.
    // just doing it for avoiding unnecessary widget rebuild.
    await Provider.of<Products>(context, listen: false).fetchandsave(true);
  }

  @override
  Widget build(BuildContext context) {
    // listen false.... why?
    // using productclass here would create an infinite loop. So use consumer instead of Provider.of()...
    // final productclass = Provider.of<Products>(
    //   context,
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditUserProduct.route);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: onRefresh(context),
        builder: ((context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => onRefresh(context),
                    child: Consumer<Products>(
                      builder: ((context, value, _) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemBuilder: ((context, index) => UserProducts(
                                  id: value.items[index].id,
                                  imageurl: value.items[index].imageUrl,
                                  title: value.items[index].title)),
                              itemCount: value.items.length,
                            ),
                          )),
                    ),
                  )),
      ),
    );
  }
}
