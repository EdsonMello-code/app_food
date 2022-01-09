import 'dart:io';

import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/externals/adapters/http_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Dio client category: ', () {
    test('Should return response with data not null then method get is called.',
        () async {
      final dio = DioMock(BaseOptions(
        baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
      ));

      final httpClient = DioClient(dio);

      when(() => dio.get(any())).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: [
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

      final category = await httpClient.get(url: 'url');
      expect(category.data, isList);
      expect(category.data[0]['title'], isNotNull);
      expect(category.data[0]['title'], isNotEmpty);
      expect(category.data[0]['foods'][0], isMap);
      expect(category.data[0]['foods'][0]['imageUrl'], isNotNull);
      expect(category.data[0]['foods'][0]['imageUrl'], isNotEmpty);
      expect(category.data[0]['foods'][0]['name'], isNotNull);
      expect(category.data[0]['foods'][0]['name'], isNotEmpty);
      expect(category.data[0]['foods'][0]['distances'], isNotNull);
      expect(category.data[0]['foods'][0]['price'], isNotNull);
    });

    test('Should return error then method get is called.', () async {
      final dio = DioMock(BaseOptions(
        baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
      ));

      final httpClient = DioClient(dio);

      when(() => dio.get(any())).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: '/',
          ),
        ),
      );
      try {
        final category = await httpClient.get(url: 'url');
        expect(category, isNull);
      } catch (error) {
        expect(error, isException);
      }
    });
  });

  group('Dio client category: ', () {
    test('Should return list of Foods then the method get is called', () async {
      final dio = DioMock(BaseOptions(
        baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
      ));

      final client = DioClient(dio);

      when(() => dio.get(any())).thenAnswer((_) async =>
          Response(requestOptions: RequestOptions(path: ''), data: [
            {
              'imageUrl': 'url',
              'name': 'Pizza',
              'distances': 2.2,
              'price': 33.3,
            }
          ]));

      final response = await client.get(url: 'Pizza');

      expect(response.data, isList);
      expect(response.data[0], isMap);
      expect(response.data[0]['imageUrl'], isNotNull);
      expect(response.data[0]['imageUrl'], isNotEmpty);
      expect(response.data[0]['name'], isNotEmpty);
      expect(response.data[0]['distances'], isNotNull);
      expect(response.data[0]['price'], isNotNull);
    });

    test('Should return error then the method get is called', () async {
      final dio = DioMock(BaseOptions(
        baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
      ));

      final client = DioClient(dio);

      when(() => dio.get(any())).thenThrow(FoodError('Data is null.'));

      try {
        final response = await client.get(url: 'Pizza');
        expect(response, isNull);
      } catch (error) {
        expect(error, isException);
      }
    });
  });
}

class DioMock extends Mock implements Dio {
  @override
  final BaseOptions options;
  DioMock(this.options);
}
