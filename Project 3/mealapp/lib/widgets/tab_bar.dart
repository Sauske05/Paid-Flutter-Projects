import 'package:flutter/material.dart';

import './categories.dart';
import './Favourites.dart';
import './Main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.category_sharp,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourites',
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: const TabBarView(
          children: [Categories(), Favourites()],
        ),
      ),
    );
  }
}
