import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/externals/http_client/models/food_model.dart';

class CategoryModel implements Category {
  @override
  final List<FoodModel> foods;

  @override
  final String title;

  const CategoryModel({required this.foods, required this.title});

  factory CategoryModel.fromMap({required Map map}) {
    final foods = map['foods'] as List;
    print(foods);
    return CategoryModel(
        foods: foods.map((food) => FoodModel.fromMap(food)).toList(),
        title: map['title']);
  }
}
