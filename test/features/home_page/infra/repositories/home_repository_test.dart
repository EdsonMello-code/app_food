import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:app_food/features/home_page/infra/datasources/home_datasource.dart';
import 'package:app_food/features/home_page/infra/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Get location repository: ', () {
    test(
        'Should have return location ok then call the method geCurrentLocation',
        () async {
      final homeDatasource = HomeDatasourceMock();

      when(() => homeDatasource.geCurrentLocation()).thenAnswer(
        (invocation) async => const LocationEntity(
          lat: -21.5070334899,
          long: -55.4119080998,
          city: 'Mata Grande',
        ),
      );

      final homeRepository =
          await HomeRepositoryImpl(datasource: homeDatasource).getLocation();

      final location = homeRepository.fold((l) => null, (r) => r)!;
      expect(location, isNotNull);
      expect(location.lat, equals(-21.5070334899));
      expect(location.long, equals(-55.4119080998));
      expect(location.city, equals('Mata Grande'));
    });

    test(
        'Should have return error then call the method geCurrentLocation and return um Exception',
        () async {
      Future<LocationEntity> getLocationEntity() async {
        try {
          throw const LocationFailure(
              message:
                  'Latitude: null and longitude: null, both not must be null.');
        } on LocationFailure {
          rethrow;
        }
      }

      final homeDatasource = HomeDatasourceMock();

      when(() => homeDatasource.geCurrentLocation()).thenAnswer(
        (invocation) => getLocationEntity(),
      );

      final homeRepository = await HomeRepositoryImpl(
        datasource: homeDatasource,
      ).getLocation();

      final location = homeRepository.fold((l) => l, (r) => null)!;
      expect(location, isNotNull);
      expect(
        location.message,
        equals(
          'Latitude: null and longitude: null, both not must be null.',
        ),
      );
    });
  });
}

class HomeDatasourceMock extends Mock implements HomeDatasource {}
