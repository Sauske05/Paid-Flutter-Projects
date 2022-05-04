import 'package:flutter/material.dart';

import '../models/dummydata.dart';
import './meal_item.dart';

class Categorydetail extends StatelessWidget {
  // final String title;
  // Categorydetail(this.title);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final titlecontent = routeArgs['title'];
    final id = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(id);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(titlecontent),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItems(
                  imageurl: categoryMeals[index].imageUrl,
                  id: categoryMeals[index].id,
                  title: categoryMeals[index].title,
                  affordability: categoryMeals[index].affordability,
                  complexity: categoryMeals[index].complexity,
                  duration: categoryMeals[index].duration);
            },
            itemCount: categoryMeals.length,
          ),
        ));
  }
}
