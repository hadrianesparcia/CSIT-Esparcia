import 'package:flutter/material.dart';
import '../models/filter.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Map<Filter, bool> _filters;

  static const _labels = {
    Filter.glutenFree: 'Gluten-free',
    Filter.lactoseFree: 'Lactose-free',
    Filter.vegetarian: 'Vegetarian',
    Filter.vegan: 'Vegan',
  };

  @override
  void initState() {
    super.initState();
    _filters = {...widget.currentFilters};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop(_filters); // RETURN data to previous screen
        },
        child: Column(
          children: [
            for (final f in Filter.values)
              SwitchListTile(
                value: _filters[f]!,
                onChanged: (value) => setState(() => _filters[f] = value),
                title: Text(_labels[f]!),
                subtitle: Text('Only include ${_labels[f]!.toLowerCase()} meals.'),
              ),
          ],
        ),
      ),
    );
  }
}