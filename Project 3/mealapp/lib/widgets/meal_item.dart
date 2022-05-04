import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/meal.dart';
import './meal_detail_screen.dart';

class MealItems extends StatelessWidget {
  // const MealItems({Key key}) : super(key: key);
  final String id;
  final String imageurl;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final int duration;
  MealItems(
      {@required this.imageurl,
      @required this.id,
      @required this.title,
      @required this.affordability,
      @required this.complexity,
      @required this.duration});

  void onTap(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetail.routename, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageurl,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.schedule),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('$duration minutes')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
