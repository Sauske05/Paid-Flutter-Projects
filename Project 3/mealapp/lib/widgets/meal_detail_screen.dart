import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';

import '../models/dummydata.dart';

class MealDetail extends StatelessWidget {
  static const routename = '/meal_detail';

  MealDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final selectmeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);

    Widget listitemwidget(List<String> text, int itemcount) {
      return Container(
        height: 100,
        width: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Text(text[index]),
            );
          },
          itemCount: itemcount,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectmeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectmeal.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Ingredients',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 1,
            ),
            // selectmeal.ingredients[index] fot text
            //  selectmeal.ingredients.length for count
            listitemwidget(
                selectmeal.ingredients, selectmeal.ingredients.length),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            listitemwidget(selectmeal.steps, selectmeal.steps.length)
          ],
        ),
      ),
    );
  }
}
