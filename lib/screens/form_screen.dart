import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prueba/controllers/geocoding_service.dart';
import 'dart:io';

class FormScreen extends StatefulWidget {
  final String? jornada;
  final String? supervisor;
  final String? patente;

  // Constructor para recibir los parámetros jornada, supervisor y patente
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

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    // Inicializar la fecha y hora del sistema
    final now = DateTime.now();
    fecha = DateFormat('dd/MM/yyyy').format(now);
    hora = DateFormat('HH:mm').format(now);

    // Inicializar los valores recibidos por parámetros
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
      address = await GeocodingService().getAddressFromCoordinates(latitude!, longitude!);
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
        title: const Text('Formulario de Actividad'),
      ),
      body: SingleChildScrollView(  // Agregar SingleChildScrollView aquí
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(  // Cambiar a Column
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha',
                    hintText: 'DD/MM/AAAA',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: fecha),
                  readOnly: true,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Hora',
                    hintText: 'HH:MM',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: hora),
                  readOnly: true,
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Jornada',
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Supervisor',
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Patente',
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Kilometraje',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      kilometraje = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el kilometraje';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                const Text(
                  'Foto odómetro *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                if (_cameraController?.value.isInitialized ?? false)
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                        Center(
                          child: Container(
                            width: 200,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final XFile? image = await _cameraController?.takePicture();
                      if (image != null) {
                        setState(() {
                          odometroImage = image;
                        });
                      }
                    } catch (e) {
                      print('Error al tomar la foto: $e');
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Tomar Foto'),
                ),
                const SizedBox(height: 16),

                odometroImage != null
                    ? Image.file(
                  File(odometroImage!.path),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
                    : const Text('No se ha tomado ninguna foto'),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    if (odometroImage == null) {
                      _showErrorMessage('Debe tomar una foto antes de enviar el formulario.');
                      return;
                    }

                    await _getLocation();
                    if (address == null) {
                      _showErrorMessage('No se pudo obtener la dirección.');
                      return;
                    }

                    print('Formulario enviado con la dirección: $address');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Formulario enviado')),
                    );
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
