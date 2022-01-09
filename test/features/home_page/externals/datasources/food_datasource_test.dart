import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/externals/adapters/http_client/my_client_http.dart';
import 'package:app_food/features/home_page/externals/datasources/food_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Food datasource: ', () {
    test(
        'Should return list of category then the method getFoodByCategoryDatasource.',
        () async {
      final httpClient = HttpClientMock();
      final foodDatasource = FoodDatasourceImpl(client: httpClient);

      when(() => httpClient.get(url: any(named: 'url'))).thenAnswer((_) async =>
          Response(requestOptions: RequestOptions(path: 'url'), data: [
            {
              "title": "Fast Food",
              "foods": [
                {
                  'imageUrl': 'url',
                  'name': 'Pizza',
                  'distances': 2.2,
                  'price': 33.3,
                }
              ]
            }
          ]));

      final category = await foodDatasource.getFoodByCategoryDatasource(
        category: 'Fast Food',
      );

      expect(category[0].title, isNotEmpty);
    });

    test('Should return Food erro then the method getFoodByCategoryDatasource.',
        () async {
      final httpClient = HttpClientMock();
      final foodDatasource = FoodDatasourceImpl(client: httpClient);

      when(() => httpClient.get(url: any(named: 'url')))
          .thenThrow(FoodError('Body is null'));

      try {
        final category = await foodDatasource.getFoodByCategoryDatasource(
          category: 'Fast Food',
        );

        expect(category, isNull);
      } catch (e) {
        expect(e, isException);
      }
    });
  });
}

class HttpClientMock extends Mock implements MyClientHttp {}
