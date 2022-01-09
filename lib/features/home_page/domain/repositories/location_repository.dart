import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<LocationFailure, LocationEntity>> getLocation();
}
