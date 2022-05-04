import 'package:flutter/material.dart';
import './category_items_screens.dart';

class Categoryitem extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  Categoryitem({@required this.color, @required this.title, this.id});

  void onpressed(BuildContext context) {
    // 'id' : 'c1', 'title' : 'Hamburger'
    // 'id' : 'c2', 'title' : 'Fish'
    Navigator.of(context)
        .pushNamed('/category_detail', arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onpressed(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
