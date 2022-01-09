import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/entities/food.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:app_food/features/home_page/domain/usecases/get_food_category.dart';
import 'package:app_food/features/home_page/domain/usecases/get_food_name.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Get food category: ', () {
    test(
      'Should return list of food by category then method get_food_category.',
      () async {
        final foodRepository = FoodRepositoryMock();
        final getFoodCategory = GetFoodCategory(repository: foodRepository);

        Future<Either<FoodError, List<Category>>> getCategory() async {
          try {
            return const Right([
              Category(title: 'Drinks', foods: [
                Food(
                    imageUrl: 'url',
                    name: 'Orange juice',
                    distances: 1.1,
                    price: 3.2),
                Food(
                    imageUrl: 'url',
                    name: 'kiwi juice',
                    distances: 30.0,
                    price: 3.0),
              ])
            ]);
          } on FoodError catch (error) {
            return Left(error);
          }
        }

        when(() => foodRepository.getFoodByCategory(
            category: any(named: 'category'))).thenAnswer(
          (_) => getCategory(),
        );

        final category = (await getFoodCategory(category: 'Drink'))
            .fold((l) => null, (r) => r)!;

        expect(category, isNotNull);
        expect(category[0].title, equals('Drinks'));
        expect(category[0].title, isNotEmpty);
        expect(category[0].foods[0].imageUrl, isNotEmpty);
        expect(category[0].foods[0].name, isNotEmpty);
        expect(category[0].foods[0].price > 0, isTrue);
      },
    );

    test(
      'Should return null then method get_food_category.',
      () async {
        final foodRepository = FoodRepositoryMock();
        final getFoodCategory = GetFoodCategory(repository: foodRepository);

        Future<Either<FoodError, List<Category>>> getCategory() async {
          try {
            throw FoodError('Food error: list of category is null.');
          } on FoodError catch (error) {
            return Left(error);
          }
        }

        when(() => foodRepository.getFoodByCategory(
            category: any(named: 'category'))).thenAnswer(
          (_) => getCategory(),
        );

        final category = (await getFoodCategory(category: 'Drink'))
            .fold((l) => l, (r) => null)!;

        expect(category, isNotNull);
        expect(category.message, 'Food error: list of category is null.');
      },
    );
  });

  group('Get food Name', () {
    test('Should return a list of foods then the method GetFoodName is called.',
        () async {
      final foodRepository = FoodRepositoryMock();

      final getFoodByName = GetFoodName(repository: foodRepository);

      Future<Either<FoodError, List<Food>>> getFoods() async {
        try {
          return const Right([
            Food(imageUrl: 'url', name: 'name', distances: 2.2, price: 232.2)
          ]);
        } on FoodError catch (error) {
          return Left(error);
        }
      }

      when(() => foodRepository.getFoodByName(foodName: any(named: 'foodName')))
          .thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await getFoodByName(foodName: 'Fish')).fold(
        (l) => null,
        (r) => r,
      )!;

      expect(foods, isNotEmpty);
      expect(foods[0].imageUrl, isNotEmpty);
      expect(foods[0].name, isNotEmpty);
    });

    test('Should return error then the method GetFoodName is called.',
        () async {
      final foodRepository = FoodRepositoryMock();

      final getFoodByName = GetFoodName(repository: foodRepository);

      Future<Either<FoodError, List<Food>>> getFoods() async {
        try {
          throw FoodError('Foods is null');
        } on FoodError catch (error) {
          return Left(error);
        }
      }

      when(() => foodRepository.getFoodByName(foodName: any(named: 'foodName')))
          .thenAnswer(
        (_) => getFoods(),
      );

      final foodError = (await getFoodByName(foodName: 'Fish')).fold(
        (l) => l,
        (r) => null,
      )!;

      expect(foodError, isException);
    });
  });
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
