import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/externals/http_client/my_client_http.dart';

abstract class FoodDatasource {
  final MyClientHttp client;

  FoodDatasource({required this.client});
  Future<List<Category>> getFoodByCategoryDatasource({
    required String category,
  });
}
