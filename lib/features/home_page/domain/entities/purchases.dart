import 'package:app_food/features/home_page/domain/entities/food.dart';

class Purchases {
  final String total;
  final String to;
  final List<Food> foods;

  const Purchases({
    required this.total,
    required this.foods,
    required this.to,
  });
}
