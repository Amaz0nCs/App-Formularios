import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/form_data.dart';
import '../controllers/geocoding_service.dart';


//aqui se encuentran conexiones permisos y cosas varias
class FormController {
  Future<String?> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('El servicio de ubicación está desactivado.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Los permisos de ubicación fueron denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Los permisos de ubicación están denegados permanentemente.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    return await GeocodingService().getAddressFromCoordinates(latitude, longitude);
  }

  Future<String?> uploadOdometroImage(File imageFile) async {
    var uri = Uri.parse('http://200.2.202.154:8045/controlvehiculos/process_image.php');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (data['success'] == true && data['kilometraje'] != null) {
        return data['kilometraje'][0];
      } else {
        throw Exception('No se pudo extraer el kilometraje de la imagen.');
      }
    } else {
      throw Exception('Error en la carga de la imagen.');
    }
  }

  Future<void> sendFormData(FormData formData) async {
    var uri = Uri.parse('http://10.0.2.2/insert.php');
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formData.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }

    var data = jsonDecode(response.body);
    if (data['success'] != true) {
      throw Exception('Error al enviar los datos: ${data['message']}');
    }
  }
}
