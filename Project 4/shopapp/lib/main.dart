import 'package:flutter/material.dart';
import './screens/HomePage.dart';
import './screens/product_Detail_Screen.dart';

import 'package:provider/provider.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './screens/cart_screen.dart';
import './provider/orders.dart';
import './screens/orders_screen.dart';
import './screens/User_Products_Screen.dart';
import './screens/edit_User_Product.dart';
import './screens/auth_screen.dart';
import './provider/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        // products...
        // proxy provider rebuilds when auth class rebuilds.
        ChangeNotifierProxyProvider<Auth, Products>(
            update: ((context, value, previous) =>
                // may face null error! check this code.
                // this works. Understand this line of code.  Lecture: 270
                // these values are for constructor of products. Check products.dart
                Products(value.token, previous == null ? [] : previous.items,
                    value.userID))),
        ChangeNotifierProvider(
          create: ((context) => Cart()),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
            //Understand this line of code.  Lecture: 270
            update: (ctx, value, previous) =>
                Order(value.token, previous == null ? [] : previous.order))
        // ChangeNotifierProvider(create: (context) => Order())
      ],
      child: Consumer<Auth>(
        builder: (context, authclass, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: authclass.isAuth ? HomePage() : AuthScreen(),
            // home: AuthScreen(),
            // AuthScreen.
            //HomePagw() is for home.
            routes: {
              ProductDetailScreen.routename: (ctx) {
                return ProductDetailScreen();
              },
              CartScreen.route: (context) {
                return CartScreen();
              },
              OrderScreen.routename: (context) {
                return OrderScreen();
              },
              UserProductScreen.route: (ctx) => UserProductScreen(),
              EditUserProduct.route: (c) => EditUserProduct(),
            },
            title: 'MyShop',
            theme: ThemeData(
              primaryColor: Colors.purple,
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.purple,
                  onPrimary: Colors.white,
                  secondary: Colors.deepOrangeAccent,
                  onSecondary: Colors.red,
                  onBackground: Colors.black54,
                  background: Colors.purple,
                  error: Colors.pink,
                  onError: Colors.blue,
                  surface: Colors.white38,
                  onSurface: Colors.white),
            )),
      ),
    );
  }
}
