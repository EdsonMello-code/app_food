import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:app_food/features/home_page/externals/geocoding_adpter.dart';
import 'package:app_food/features/home_page/infra/datasources/home_page_datasource.dart';
import 'package:geocoding/geocoding.dart' as geocoding hide Location;
import 'package:location/location.dart';

class HomePageDatasourceImpl implements HomePageDatasource {
  final Location location;
  final GeocodingAdpter geocoding;

  HomePageDatasourceImpl({required this.location, required this.geocoding});

  @override
  Future<LocationEntity> geCurrentLocation() async {
    try {
      final latLong = await location.getLocation();
      print(latLong);
      if (latLong.latitude == null || latLong.longitude == null) {
        throw LocationFailure(
          message:
              'Latitude: ${latLong.latitude} and longitude: ${latLong.longitude}, both not must be null.',
        );
      }

      final locations = await geocoding.placemarkFromCoordinates(
          latLong.latitude!, latLong.longitude!);

      return LocationEntity(
          lat: latLong.latitude!,
          long: latLong.longitude!,
          city: locations[0].subLocality!);
    } catch (e) {
      throw LocationFailure(message: e.toString());
    }
  }
}
