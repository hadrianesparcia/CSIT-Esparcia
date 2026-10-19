import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';
import 'categories.dart';
import 'meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleFavorite(Meal meal) {
    final exists = _favoriteMeals.contains(meal);
    setState(() {
      if (exists) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(exists ? 'Removed from favorites.' : 'Added to favorites!'),
      ),
    );
  }

  bool _isFavorite(Meal meal) => _favoriteMeals.contains(meal);

  @override
  Widget build(BuildContext context) {
    Widget page = CategoriesScreen(
      availableMeals: dummyMeals,
      onToggleFavorite: _toggleFavorite,
      isFavorite: _isFavorite,
    );
    var title = 'Pick your category';

    if (_selectedPageIndex == 1) {
      page = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
        isFavorite: _isFavorite,
      );
      title = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (i) => setState(() => _selectedPageIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}