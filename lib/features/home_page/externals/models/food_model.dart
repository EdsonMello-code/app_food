import 'package:app_food/features/home_page/domain/entities/food.dart';

class FoodModel implements Food {
  @override
  final double distances;

  @override
  final String imageUrl;

  @override
  final String name;

  @override
  final double price;

  const FoodModel({
    required this.distances,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory FoodModel.fromMap(Map map) {
    print(map);
    return FoodModel(
      distances: map['distances'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      price: map['price'],
    );
  }
}
