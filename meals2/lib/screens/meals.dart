import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final bool isFavorite;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late bool _isFavorite = widget.isFavorite;

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final heading = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.star : Icons.star_border),
            onPressed: () {
              widget.onToggleFavorite(meal);
              setState(() => _isFavorite = !_isFavorite);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const SizedBox(
                height: 300,
                child: Center(child: Icon(Icons.broken_image, size: 48)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ingredients', style: heading),
                  const SizedBox(height: 8),
                  for (final ingredient in meal.ingredients)
                    Text('• $ingredient'),
                  const SizedBox(height: 24),
                  Text('Steps', style: heading),
                  const SizedBox(height: 8),
                  for (var n = 0; n < meal.steps.length; n++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${n + 1}. ${meal.steps[n]}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}