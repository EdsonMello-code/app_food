import 'package:app_food/features/home_page/domain/entities/food.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetFoodName {
  final FoodRepository repository;

  const IGetFoodName({required this.repository});

  Future<Either<FoodError, List<Food>>> call({required String foodName});
}

class GetFoodName implements IGetFoodName {
  const GetFoodName({required this.repository});

  @override
  final FoodRepository repository;

  @override
  Future<Either<FoodError, List<Food>>> call({required String foodName}) {
    return repository.getFoodByName(foodName: foodName);
  }
}
