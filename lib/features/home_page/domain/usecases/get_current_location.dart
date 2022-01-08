import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:app_food/features/home_page/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetCurrentLocation {
  Future<Either<LocationFailure, LocationEntity>> call();
}

class GetCurrentLocation implements IGetCurrentLocation {
  final HomeRepository repository;

  GetCurrentLocation({required this.repository});
  @override
  Future<Either<LocationFailure, LocationEntity>> call() {
    return repository.getLocation();
  }
}
