import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItems extends StatefulWidget {
  final String id;
  final String productID;
  final String title;
  final double price;
  final double quantity;

  CartItems({this.id, this.productID, this.price, this.quantity, this.title});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // this is the id of card item.   Explain the difference between card Item and Product Item.
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to remove the item?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'))
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<Cart>(
                // listen should be false. Why?
                context,
                listen: false)
            .removeitem(widget.productID);
      },
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: FittedBox(
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  // Text needs to be changed.
                  child: Text(
                    '\$${widget.price.toString()}',
                  ),
                  radius: 50,
                ),
              ),
              title: Text(widget.title),
              subtitle: Text('Total : \$${widget.price * widget.quantity}'),
              trailing: Text('${widget.quantity} x '),
            ),
          )),
    );
  }
}
