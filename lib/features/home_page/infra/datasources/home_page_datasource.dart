import 'package:app_food/features/home_page/domain/entities/location.dart';

abstract class HomePageDatasource {
  Future<LocationEntity> geCurrentLocation();
}
