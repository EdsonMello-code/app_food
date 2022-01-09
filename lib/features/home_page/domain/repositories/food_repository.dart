import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/infra/datasources/food_datasource.dart';
import 'package:dartz/dartz.dart';

abstract class FoodRepository {
  final FoodDatasource datasource;

  FoodRepository({required this.datasource});
  Future<Either<FoodError, List<Category>>> getFoodByCategory({
    required String category,
  });
}
