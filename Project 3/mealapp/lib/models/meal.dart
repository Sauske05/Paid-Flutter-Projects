import 'package:flutter/foundation.dart';

enum Affordability { Affordable, Pricey, Luxurious }

enum Complexity { Simple, Challenging, Hard }

class Meal {
  String id;
  List<String> categories;
  String title;
  String imageUrl;
  int duration;
  List<String> ingredients;
  List<String> steps;
  bool isGlutenFree;
  bool isVegan;
  bool isVegetarian;
  bool isLactoseFree;
  Affordability affordability;
  Complexity complexity;

  Meal(
      {@required this.id,
      @required this.categories,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.ingredients,
      @required this.isGlutenFree,
      @required this.isLactoseFree,
      @required this.isVegan,
      @required this.isVegetarian,
      @required this.steps,
      @required this.affordability,
      @required this.complexity});
}
