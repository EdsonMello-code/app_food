import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:app_food/features/home_page/domain/repositories/home_repository.dart';
import 'package:app_food/features/home_page/domain/usecases/get_current_location.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group("Get current location usecase: ", () {
    test('Should has location with latitude, longitude and city ', () async {
      final homePageRepositoryMock = HomePageRepositoryMock();

      final getCurrentLocation = GetCurrentLocation(
        repository: homePageRepositoryMock,
      );

      Future<Either<LocationFailure, LocationEntity>>
          getLocationEntity() async {
        try {
          return const Right(LocationEntity(
            lat: -21.5070334899,
            long: -55.4119080998,
            city: 'Mata Grande',
          ));
        } catch (e) {
          return const Left(LocationFailure(message: 'Teste'));
        }
      }

      when(() {
        return homePageRepositoryMock.getLocation();
      }).thenAnswer((invocation) {
        return getLocationEntity();
      });

      final currentLocation =
          (await getCurrentLocation()).fold((l) => null, (r) => r)!;
      expect(
          currentLocation,
          equals(
            const LocationEntity(
              lat: -21.5070334899,
              long: -55.4119080998,
              city: 'Mata Grande',
            ),
          ));
    });

    test(
        'Should have error then return error of get latitude, longitude and city',
        () async {
      final homePageRepositoryMock = HomePageRepositoryMock();

      final getCurrentLocation = GetCurrentLocation(
        repository: homePageRepositoryMock,
      );

      Future<Either<LocationFailure, LocationEntity>>
          getLocationEntity() async {
        try {
          throw const LocationFailure(
              message:
                  'Latitude: null and longitude: null, both not must be null.');
        } on LocationFailure catch (e) {
          return Left(e);
        }
      }

      when(() {
        return homePageRepositoryMock.getLocation();
      }).thenAnswer((invocation) {
        return getLocationEntity();
      });

      final locationFailure =
          (await getCurrentLocation()).fold((l) => l, (r) => null)!;
      expect(locationFailure.message, isNotNull);
    });
  });
}

class HomePageRepositoryMock extends Mock implements HomeRepository {}
