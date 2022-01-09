import 'package:app_food/features/home_page/externals/geocoding_adpter.dart';
import 'package:app_food/features/home_page/externals/location_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:mocktail/mocktail.dart';
import 'package:location/location.dart';

void main() {
  group('Datasource: ', () {
    test(
        'Should have fech location of datasource then call method placemarkFromCoordinates',
        () async {
      final geocodingAdapterMock = GeocodingAdapterMock();
      final locationMock = LocationMock();

      final homeDatasource = LocationDatasourceImpl(
        location: locationMock,
        geocoding: geocodingAdapterMock,
      );

      Future<LocationDataMock> getLocation() async => LocationDataMock();

      when(
        () => geocodingAdapterMock.placemarkFromCoordinates(
          any(),
          any(),
        ),
      ).thenAnswer((_) async => [
            Placemark(
              subLocality: 'Mata Grande',
            )
          ]);

      when(
        () => locationMock.getLocation(),
      ).thenAnswer((_) => getLocation());

      final location = await homeDatasource.geCurrentLocation();

      expect(location.lat, equals(2.2));
      expect(location.city, equals('Mata Grande'));
      expect(location.long, equals(2.2));
    });
  });
}

class GeocodingAdapterMock extends Mock implements GeocodingAdpter {}

class LocationMock extends Mock implements Location {}

class LocationDataMock implements LocationData {
  @override
  // TODO: implement accuracy
  double? get accuracy => 2.2;

  @override
  // TODO: implement altitude
  double? get altitude => 2.2;

  @override
  // TODO: implement elapsedRealtimeNanos
  double? get elapsedRealtimeNanos => 2.2;

  @override
  // TODO: implement elapsedRealtimeUncertaintyNanos
  double? get elapsedRealtimeUncertaintyNanos => 2.2;

  @override
  // TODO: implement heading
  double? get heading => 2.2;

  @override
  // TODO: implement headingAccuracy
  double? get headingAccuracy => 2.2;

  @override
  // TODO: implement isMock
  bool? get isMock => true;

  @override
  // TODO: implement latitude
  double? get latitude => 2.2;

  @override
  // TODO: implement longitude
  double? get longitude => 2.2;

  @override
  // TODO: implement provider
  String? get provider => '';

  @override
  // TODO: implement satelliteNumber
  int? get satelliteNumber => 2;

  @override
  // TODO: implement speed
  double? get speed => 2.2;

  @override
  // TODO: implement speedAccuracy
  double? get speedAccuracy => 2.2;

  @override
  // TODO: implement time
  double? get time => 2.2;

  @override
  // TODO: implement verticalAccuracy
  double? get verticalAccuracy => 2.2;
}
