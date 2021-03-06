import 'package:app_food/features/home_page/domain/errors/location_error.dart';
import 'package:app_food/features/home_page/domain/entities/location.dart';
import 'package:app_food/features/home_page/domain/repositories/location_repository.dart';
import 'package:app_food/features/home_page/infra/datasources/location_datasource.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements LocationRepository {
  final LocationDatasource datasource;

  const HomeRepositoryImpl({required this.datasource});
  @override
  Future<Either<LocationFailure, LocationEntity>> getLocation() async {
    try {
      final currentLocation = await datasource.geCurrentLocation();
      return Right(currentLocation);
    } on LocationFailure catch (error) {
      return Left(error);
    }
  }
}
