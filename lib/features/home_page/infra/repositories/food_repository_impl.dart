import 'package:app_food/features/home_page/domain/entities/food.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:app_food/features/home_page/infra/datasources/food_datasource.dart';
import 'package:dartz/dartz.dart';

class FoodRepositoryImpl implements FoodRepository {
  @override
  final FoodDatasource datasource;

  FoodRepositoryImpl({required this.datasource});

  @override
  Future<Either<FoodError, List<Category>>> getFoodByCategory({
    required String category,
  }) async {
    try {
      final foods =
          await datasource.getFoodByCategoryDatasource(category: category);
      return Right(foods);
    } on FoodError catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FoodError, List<Food>>> getFoodByName(
      {required String foodName}) async {
    try {
      final foods =
          await datasource.getFoodByNameDatasource(foodName: foodName);
      return Right(foods);
    } on FoodError catch (error) {
      return Left(error);
    }
  }
}
