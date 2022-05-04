import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './Filters.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget listTileCreator(String txt, IconData icon, Function pagepopup) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        txt,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      onTap: pagepopup,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 150,
            width: double.infinity,
            color: Colors.amber[200],
            child: const Text(
              'Cooking Up!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          listTileCreator('Meal', Icons.restaurant, () {
            Navigator.of(context).pushNamed('/TabScreen');
          }),
          listTileCreator('Filters', Icons.settings, () {
            Navigator.of(context).pushNamed(Filters.routename);
          }),
        ],
      ),
    );
  }
}
