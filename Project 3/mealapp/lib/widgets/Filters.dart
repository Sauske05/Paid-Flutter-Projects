import 'package:flutter/material.dart';
import './Main_drawer.dart';

class Filters extends StatefulWidget {
  static const routename = '/Filters';

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _glutonfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  Widget build(BuildContext context) {
    Widget _createListTile(
      String title,
      String descp,
      bool currentvalue,
      Function onchanged,
    ) {
      return SwitchListTile(
          title: Text(title),
          subtitle: Text(descp),
          value: currentvalue,
          onChanged: onchanged);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Adjust your meal choices here',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _createListTile(
                    'Gluten Free',
                    'Only Includes Gluten Free Meals',
                    _glutonfree, (bool newvalue) {
                  setState(() {
                    _glutonfree = newvalue;

                    print(_glutonfree);
                  });
                }),
                SwitchListTile(
                  value: _vegetarian,
                  onChanged: (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  },
                  title: const Text('Full Veg!'),
                  subtitle: const Text('Only contains veggies!'),
                ),
                Switch(
                    value: _lactosefree,
                    onChanged: (value) {
                      setState(() {
                        _lactosefree = value;
                        print(_lactosefree);
                      });
                    })
              ],
            ))
          ],
        ));
  }
}
