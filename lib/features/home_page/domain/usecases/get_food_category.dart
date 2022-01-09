import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetFoodCategory {
  Future<Either<FoodError, List<Category>>> call({required String category});
}

class GetFoodCategory implements IGetFoodCategory {
  final FoodRepository repository;

  GetFoodCategory({required this.repository});

  @override
  Future<Either<FoodError, List<Category>>> call({
    required String category,
  }) async {
    return repository.getFoodByCategory(category: category);
  }
}
