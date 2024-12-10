import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:prueba/controllers/geocoding_service.dart';

class FormScreen extends StatefulWidget {
  final String? jornada;
  final String? supervisor;
  final String? patente;

  const FormScreen({
    super.key,
    this.jornada,
    this.supervisor,
    this.patente,
  });

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedJornada;
  String? supervisor;
  String? patente;
  String? conductor;
  String? kilometraje;
  String? fecha;
  String? hora;
  CameraController? _cameraController;
  XFile? odometroImage;
  List<CameraDescription>? cameras;
  double? latitude;
  double? longitude;
  String? address;

  final Color customColor = Color(0xFF1E225B); // El color morado personalizado
  final Color buttonTextColor = Colors.white;  // Color del texto de los botones
  final Color iconColor = Colors.white;  // Color de los iconos

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    // Iniciar la fecha y hora del sistema
    final now = DateTime.now();
    fecha = DateFormat('dd/MM/yyyy').format(now);
    hora = DateFormat('HH:mm').format(now);

    // Iniciar los valores recibidos por los parámetros de arriba
    selectedJornada = widget.jornada;
    supervisor = widget.supervisor;
    patente = widget.patente;
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    CameraDescription backCamera =
    cameras!.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

    _cameraController = CameraController(backCamera, ResolutionPreset.high);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorMessage('El servicio de ubicación está desactivado. Actívelo para continuar.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorMessage('Los permisos de ubicación fueron denegados.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showErrorMessage('Los permisos de ubicación están denegados permanentemente.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    if (latitude != null && longitude != null) {
      print('Ubicación obtenida: Lat: $latitude, Lon: $longitude');
      address = await GeocodingService().getAddressFromCoordinates(latitude!, longitude!);
      print('Dirección obtenida: $address');
    }
  }

  // Función para subir la imagen y obtener el kilometraje
  Future<void> _uploadOdometroImage() async {
    if (odometroImage == null) {
      _showErrorMessage('Por favor, tome o seleccione una foto.');
      return;
    }

    try {
      var uri = Uri.parse('http://200.2.202.154:8045/controlvehiculos/process_image.php');
      var request = http.MultipartRequest('POST', uri);

      // Agregar la imagen como archivo
      request.files.add(await http.MultipartFile.fromPath('image', odometroImage!.path));

      // Realizar la solicitud
      var response = await request.send();

      if (response.statusCode == 200) {
        // Procesar la respuesta
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        if (data['success'] == true && data['kilometraje'] != null) {
          setState(() {
            kilometraje = data['kilometraje'][0];
          });
          print('Kilometraje: $kilometraje');
        } else {
          _showErrorMessage('No se pudo extraer el kilometraje de la imagen.');
        }
      } else {
        _showErrorMessage('Error en la carga de la imagen.');
      }
    } catch (e) {
      _showErrorMessage('Ocurrió un error al procesar la imagen: $e');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,  // Fondo blanco
        elevation: 0,  // Elimina la sombra del AppBar
        title: Padding(
          padding: const EdgeInsets.only(left: 0),  // Eliminar padding para mover el logo hacia la izquierda
          child: Image.asset(
            'Logo-CTR1.png',
            width: 80,  // Ajusta el tamaño del logo aquí
            height: 80,  // Ajusta el tamaño del logo aquí
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Alinea el texto hacia la izquierda
          children: [
            Text(
              'Bitácora Camioneta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ingrese los datos',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Formulario
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Fecha
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        hintText: 'DD/MM/AAAA',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      controller: TextEditingController(text: fecha),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),

                    // Hora
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Hora',
                        hintText: 'HH:MM',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      controller: TextEditingController(text: hora),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),

                    // Jornada
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Jornada',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      value: selectedJornada,
                      items: [
                        'Inicio Conducción',
                        'Final Conducción',
                        'Vehículo Detenido',
                        'Otro'
                      ].map((jornada) => DropdownMenuItem<String>(
                        value: jornada,
                        child: Text(jornada),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedJornada = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione una jornada';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Supervisor
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Supervisor',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      initialValue: supervisor,
                      onChanged: (value) {
                        setState(() {
                          supervisor = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre del supervisor';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Patente
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Patente',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      initialValue: patente,
                      onChanged: (value) {
                        setState(() {
                          patente = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la patente del vehículo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Kilometraje
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Kilometraje',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: customColor),
                        ),
                      ),
                      controller: TextEditingController(text: kilometraje),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),

                    // Vista previa de la cámara
                    if (_cameraController?.value.isInitialized ?? false)
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: Stack(
                          children: [
                            // Vista previa de la cámara
                            AspectRatio(
                              aspectRatio: _cameraController!.value.aspectRatio,
                              child: CameraPreview(_cameraController!),
                            ),
                            // Recuadro blanco centrado
                            Center(
                              child: Container(
                                width: 200,  // Ancho del recuadro
                                height: 150, // Alto del recuadro
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 4), // Borde blanco
                                  borderRadius: BorderRadius.circular(10),  // Bordes redondeados
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 16),

                    // Botones para tomar o seleccionar imagen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Tomar Foto
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                final image = await _cameraController?.takePicture();
                                if (image != null) {
                                  setState(() {
                                    odometroImage = image;
                                  });
                                  // Subir y procesar la imagen
                                  await _uploadOdometroImage();
                                }
                              } catch (e) {
                                print('Error al tomar la foto: $e');
                              }
                            },
                            icon: Icon(Icons.camera_alt, color: iconColor),
                            label: Text('Tomar Foto', style: TextStyle(color: buttonTextColor)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Seleccionar Foto desde la galería
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  odometroImage = image;
                                });
                                // Subir y procesar la imagen
                                await _uploadOdometroImage();
                              }
                            },
                            icon: Icon(Icons.photo_album, color: iconColor),
                            label: Text('Seleccionar Foto', style: TextStyle(color: buttonTextColor)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Vista previa de la foto seleccionada
                    if (odometroImage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Image.file(
                          File(odometroImage!.path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Botón Enviar al final de la pantalla
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            if (odometroImage == null) {
              _showErrorMessage('Por favor, tome o seleccione una foto.');
              return;
            }

            if (latitude == null || longitude == null) {
              await _getLocation();
              if (latitude == null || longitude == null) {
                return;
              }
            }

            print('Formulario completado con éxito');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Formulario enviado con éxito'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Text('Enviar', style: TextStyle(color: buttonTextColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: customColor,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
