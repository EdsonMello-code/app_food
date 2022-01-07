import 'package:geocoding/geocoding.dart' as geocoding;

class GeocodingAdpter {
  Future<List<geocoding.Placemark>> placemarkFromCoordinates(
      double latitude, double longitude) async {
    return geocoding.placemarkFromCoordinates(latitude, longitude);
  }
}
