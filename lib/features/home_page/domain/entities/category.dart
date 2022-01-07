import 'package:app_food/features/home_page/domain/entities/food.dart';

class Category {
  final String title;
  final List<Food> foods;

  const Category({
    required this.title,
    required this.foods,
  });
}
