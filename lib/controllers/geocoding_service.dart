import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.country}';
      }
      return 'Dirección no encontrada';
    } catch (e) {
      print('Error obteniendo dirección: $e');
      return 'Error al obtener dirección';
    }
  }
}
