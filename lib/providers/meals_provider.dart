import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app_v2/data/data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
