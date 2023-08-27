import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meal_app_v2/providers/favorites_provider.dart';
import 'package:meal_app_v2/screens/categories.dart';
import 'package:meal_app_v2/screens/filters.dart';
import 'package:meal_app_v2/screens/meals.dart';
import 'package:meal_app_v2/widgets/main_drawer.dart';
import 'package:meal_app_v2/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: _selectedPageIndex == 1,
          replacement: const Text('Categories'),
          child: const Text('Your Favorites'),
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: Visibility(
        visible: _selectedPageIndex == 1,
        replacement: CategoriesScreen(
          availableMeals: availableMeals,
        ),
        child: MealsScreen(
          meals: ref.watch(favoriteMealsProvider),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
