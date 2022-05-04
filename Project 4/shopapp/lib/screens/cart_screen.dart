import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../widget/cart_item.dart';
import '../provider/orders.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  static const route = './CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartclass = Provider.of<Cart>(context);
    var _isLoading = false;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),

                const Spacer(),

                // takes all the available space.
                TextButton(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Order Now'),
                  // || or and ... check
                  onPressed: (_isLoading || cartclass.totalamount <= 0)
                      ? null
                      : () async {
                          // changes to cart is listened but chaanges to order is not! Ccheck
                          setState(() {
                            _isLoading = true;
                          });

                          await Provider.of<Order>(context, listen: false)
                              .addorder(cartclass.items.values.toList(),
                                  cartclass.totalamount);

                          setState(() {
                            _isLoading = false;
                          });

                          cartclass.clearcart();
                        },
                ),

                const SizedBox(
                  width: 15,
                ),
                Chip(
                  label: Text('\$${cartclass.totalamount}'),
                  backgroundColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: ((context, index) {
            return CartItems(

                // .values.toList() ..... understand this.
                id: cartclass.items.values.toList()[index].id,
                productID: cartclass.items.keys.toList()[index],
                price: cartclass.items.values.toList()[index].price,
                quantity: cartclass.items.values.toList()[index].quantity,
                title: cartclass.items.values.toList()[index].title);
          }),
          itemCount: cartclass.items == null ? 0 : cartclass.items.length,
        ))
      ]),
    );
  }
}
