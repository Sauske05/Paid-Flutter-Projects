import 'package:flutter/material.dart';

import './widgets/categories.dart';
import './widgets/category_items_screens.dart';
import './widgets/meal_detail_screen.dart';
import './widgets/tab_bar.dart';
import './widgets/Filters.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'lactose': false,
    'vegetarian': false
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Colors.yellow[100],
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 25, 25, 1),
                ),
              )),
      home: TabScreen(),
      routes: {
        Filters.routename: (ctx) {
          return Filters();
        },
        '/TabScreen': (ctx) {
          return TabScreen();
        },
        // '/categories': (ctx) {
        //   return Categories();
        // },
        '/category_detail': (ctx) {
          return Categorydetail();
        },
        MealDetail.routename: (ctx) => MealDetail()
      },
    );
  }
}
