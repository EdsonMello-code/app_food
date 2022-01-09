import 'package:app_food/features/home_page/domain/entities/category.dart';
import 'package:app_food/features/home_page/domain/errors/food_error.dart';
import 'package:app_food/features/home_page/externals/http_client/my_client_http.dart';
import 'package:app_food/features/home_page/externals/models/category_model.dart';
import 'package:app_food/features/home_page/infra/datasources/food_datasource.dart';

class FoodDatasourceImpl implements FoodDatasource {
  @override
  final MyClientHttp client;

  const FoodDatasourceImpl({required this.client});
  @override
  Future<List<Category>> getFoodByCategoryDatasource(
      {required String category}) async {
    try {
      final response = await client.get(url: '/$category');
      final data = response.data as List;

      final categories =
          data.map((category) => CategoryModel.fromMap(map: category)).toList();
      return categories;
    } catch (e) {
      final error = e as dynamic;
      throw FoodError(error.message);
    }
  }
}
