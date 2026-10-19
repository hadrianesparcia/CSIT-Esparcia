import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title, // null when shown inside the tabs
    required this.meals,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final bool Function(Meal meal) isFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
          isFavorite: isFavorite(meal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Nothing here... try another category!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, i) => MealItem(
          meal: meals[i],
          onSelectMeal: () => _selectMeal(context, meals[i]),
        ),
      );
    }

    if (title == null) return content;

    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }
}