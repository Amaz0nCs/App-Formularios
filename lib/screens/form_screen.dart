import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/form_data.dart';
import '../controllers/form_controller.dart';

class FormScreen extends StatefulWidget {
  final String? jornada;
  final String? supervisor;
  final String? patente;
  final String? correo;

  const FormScreen({
    super.key,
    this.jornada,
    this.supervisor,
    this.patente,
    this.correo,
  });

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FormController _formController = FormController();
  final ImagePicker _imagePicker = ImagePicker();

  String? selectedJornada;
  String? supervisor;
  String? patente;
  String? destinoActividad;
  String? kilometraje;
  String? address;
  File? odometroImage;

  @override
  void initState() {
    super.initState();
    selectedJornada = widget.jornada;
    supervisor = widget.supervisor;
    patente = widget.patente;
  }

  Future<void> _selectImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        odometroImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      String? extractedKilometraje;
      if (odometroImage != null) {
        extractedKilometraje = await _formController.uploadOdometroImage(odometroImage!);
      }

      String? currentAddress = await _formController.getLocation();

      FormData formData = FormData(
        fecha: DateTime.now().toString(),
        hora: TimeOfDay.now().format(context),
        jornada: selectedJornada,
        destinoActividad: destinoActividad,
        patente: patente,
        kilometraje: extractedKilometraje,
        correo: widget.correo,
        direccion: currentAddress,
      );

      await _formController.sendFormData(formData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulario enviado con éxito'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitácora Camioneta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Destino'),
                onChanged: (value) => destinoActividad = value,
              ),
              ElevatedButton(
                onPressed: _selectImage,
                child: const Text('Tomar Foto del Odómetro'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar Formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
