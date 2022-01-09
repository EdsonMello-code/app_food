import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/entities/food.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:app_food/features/home_page/domain/usecases/get_food_category.dart';
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
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
