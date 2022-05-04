import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/provider/orders.dart';

class OrdersWidget extends StatelessWidget {
  final OrderItem orderItemclass;

  OrdersWidget(this.orderItemclass);
  @override
  Widget build(BuildContext context) {
    // final orderslist = Provider.of<Order>(context);
    return Card(
        child: Column(
      children: [
        ListTile(
          title: Text('\$${orderItemclass.amount}'),
          trailing: IconButton(
            icon: const Icon(
              Icons.expand_more,
            ),
            onPressed: () {},
          ),
        ),
      ],
    ));
  }
}
