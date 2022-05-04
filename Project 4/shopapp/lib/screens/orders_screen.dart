import 'package:flutter/material.dart';
import 'package:shopapp/widget/ordersWidget%20.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';

// Watch lecture 247 abt future builder for more info abt fture builders.

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);
  static const routename = './orderscreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // var _isLoading = false;
  @override
  // this is important. Undersand this.
  // inste3ad of this future builder can be used and is often better that initstate.
  // void initState() {
  //   Future.delayed(Duration.zero).then(
  //       (value) => Provider.of<Order>(context, listen: false).fetchandsave());
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // this will cause an infinite loop. cause of flutter builder fetch and save notify listeners. SO consumer is better instead of Provider.of<..>
    Order orderclass = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Orders',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<Order>(context, listen: false).fetchandsave(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: orderclass.order.length,
                    itemBuilder: ((context, index) {
                      return OrdersWidget(orderclass.order[index]);
                    }));
              }
            }));
  }
}
