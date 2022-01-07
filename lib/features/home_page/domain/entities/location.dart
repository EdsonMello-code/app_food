import 'package:flutter/widgets.dart';

class LocationEntity {
  final double lat;
  final double long;
  final String city;

  const LocationEntity({
    required this.lat,
    required this.long,
    required this.city,
  });
}
