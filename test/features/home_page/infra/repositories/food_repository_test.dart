import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/entities/food.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/domain/repositories/food_repository.dart';
import 'package:app_food/features/home_page/infra/datasources/food_datasource.dart';
import 'package:app_food/features/home_page/infra/repositories/food_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Food repository category: ', () {
    test(
        'Should return list of category then the getFoodByCategory method is called.',
        () async {
      final foodDatasource = FoodDataSourceMock();
      final foodRepository = FoodRepositoryImpl(datasource: foodDatasource);

      when(
        () => foodDatasource.getFoodByCategoryDatasource(
          category: any(named: 'category'),
        ),
      ).thenAnswer((_) async => [
            const Category(title: 'Fast Food', foods: [
              Food(
                imageUrl: 'url',
                name: 'Umburguer',
                distances: 20.0,
                price: 20.2,
              )
            ])
          ]);

      final category =
          (await foodRepository.getFoodByCategory(category: 'Fast Food'))
              .fold((l) => null, (r) => r)!;
      expect(category[0].title, isNotEmpty);
      expect(category.isNotEmpty, isTrue);
    });

    test(
        'Should not return list of category then the getFoodByCategory method is called.',
        () async {
      final foodDatasource = FoodDataSourceMock();
      final foodRepository = FoodRepositoryImpl(datasource: foodDatasource);

      when(
        () => foodDatasource.getFoodByCategoryDatasource(
          category: any(named: 'category'),
        ),
      ).thenThrow(FoodError('Category is null'));

      final category =
          (await foodRepository.getFoodByCategory(category: 'Fast Food'))
              .fold((l) => l, (r) => null)!;
      expect(category.message, isNotEmpty);
      expect(category.message, equals('Category is null'));
    });
  });

  group('Food repository by name: ', () {
    test('Should have return list foods then method GetFoodName', () async {
      final foodDatasource = FoodDataSourceMock();
      final foodRepository = FoodRepositoryImpl(datasource: foodDatasource);

      when(
        () => foodDatasource.getFoodByNameDatasource(
          foodName: any(named: 'foodName'),
        ),
      ).thenAnswer(
        (_) async => [
          const Food(
            imageUrl: 'imageUrl',
            name: 'name',
            distances: 202.2,
            price: 20.2,
          )
        ],
      );

      final foods = (await foodRepository.getFoodByName(foodName: 'Fish')).fold(
        (l) => null,
        (r) => r,
      )!;

      expect(foods, isNotEmpty);
      expect(foods[0].imageUrl, isNotEmpty);
      expect(foods[0].name, isNotEmpty);
    });

    test('Should have return error then method GetFoodName', () async {
      final foodDatasource = FoodDataSourceMock();
      final foodRepository = FoodRepositoryImpl(datasource: foodDatasource);

      when(
        () => foodDatasource.getFoodByNameDatasource(
          foodName: any(named: 'foodName'),
        ),
      ).thenThrow(FoodError('Food not found'));

      final foods = (await foodRepository.getFoodByName(foodName: 'Fish')).fold(
        (l) => l,
        (r) => null,
      )!;

      expect(foods, isException);
    });
  });
}

class FoodDataSourceMock extends Mock implements FoodDatasource {}
