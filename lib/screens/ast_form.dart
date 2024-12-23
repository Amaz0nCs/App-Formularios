import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../controllers/ast_controller.dart';
import '../widgets/fecha_hora_widget.dart';
import '../widgets/question_widget.dart';
import 'package:flutter/services.dart';

class AstFormScreen extends StatefulWidget {
  final String correoTrabajador;
  final String correoSupervisor;

  const AstFormScreen({
    super.key,
    required this.correoTrabajador,
    required this.correoSupervisor,
  });

  @override
  _AstFormScreenState createState() => _AstFormScreenState();
}

class _AstFormScreenState extends State<AstFormScreen> {
  final AstController controller = AstController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController trabajadorEmailController = TextEditingController();
  final TextEditingController supervisorEmailController = TextEditingController();

  List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables para resaltar campos faltantes
  bool areaFieldValid = true;
  bool trabajadorEmailValid = true;
  bool supervisorEmailValid = true;
  bool imageFieldValid = true;
  List<bool> questionFieldsValid = [];

  @override
  void initState() {
    super.initState();
    trabajadorEmailController.text = widget.correoTrabajador;
    supervisorEmailController.text = widget.correoSupervisor;

    // Inicializar las validaciones de las preguntas
    questionFieldsValid = List.generate(controller.questions.length, (_) => true);
  }

  Future<void> pickImages() async {
    if (selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No puedes seleccionar más de 5 imágenes')),
      );
      return;
    }

    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      for (var image in images) {
        final File imageFile = File(image.path);
        final int imageSizeInMB = await imageFile.length() ~/ (1024 * 1024);

        if (imageSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cada imagen no puede pesar más de 10MB')),
          );
        } else {
          setState(() {
            selectedImages.add(imageFile);
          });
        }
      }
    }
  }

  Widget buildImagePreview() {
    if (selectedImages.isEmpty) {
      return const Text('No se ha seleccionado ninguna imágen');
    }
    return GridView.builder(
      shrinkWrap: true,
      itemCount: selectedImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        return Image.file(selectedImages[index]);
      },
    );
  }

  bool _isFormValid() {
    // Validar si los campos necesarios están completos
    areaFieldValid = areaController.text.isNotEmpty;
    trabajadorEmailValid = trabajadorEmailController.text.isNotEmpty;
    supervisorEmailValid = supervisorEmailController.text.isNotEmpty;

    // Verificar si se han seleccionado respuestas en las preguntas
    imageFieldValid = selectedImages.isNotEmpty;
    bool validQuestions = true;

    for (var i = 0; i < controller.questions.length; i++) {
      var question = controller.questions[i];
      questionFieldsValid[i] = question.selectedOptions.isNotEmpty;
      if (!questionFieldsValid[i]) {
        validQuestions = false;
      }
    }

    // Verificar que todos los campos sean válidos
    return areaFieldValid && trabajadorEmailValid && supervisorEmailValid && validQuestions && imageFieldValid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'Logo-CTR1.png',
              fit: BoxFit.cover,
              width: 250,
              height: 250,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Análisis de Trabajo Seguro (AST) - FOR-SST-02',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  FechaHoraWidget(
                    fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    hora: DateFormat('HH:mm').format(DateTime.now()),
                  ),

                  const SizedBox(height: 16),

                  // Área o Sector Físico
                  const Text(
                    'Área o Sector Físico donde se realiza la actividad:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: areaController,
                    decoration: InputDecoration(
                      hintText: 'Escribe aquí...',
                      border: const OutlineInputBorder(),
                      focusedBorder: areaFieldValid
                          ? null
                          : const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Correo del Trabajador
                  const Text(
                    'Correo del Trabajador que realiza la actividad:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: trabajadorEmailController,
                    decoration: InputDecoration(
                      hintText: 'Correo del trabajador...',
                      border: const OutlineInputBorder(),
                      focusedBorder: trabajadorEmailValid
                          ? null
                          : const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Correo del Supervisor
                  const Text(
                    'Correo del Supervisor Directo:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: supervisorEmailController,
                    decoration: InputDecoration(
                      hintText: 'Correo del supervisor...',
                      border: const OutlineInputBorder(),
                      focusedBorder: supervisorEmailValid
                          ? null
                          : const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Preguntas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.questions.map((question) {
                        final questionIndex =
                        controller.questions.indexOf(question);
                        return QuestionWidget(
                          question: question,
                          onChanged: (newValue, extraText) {
                            setState(() {
                              controller.updateAnswer(
                                  controller.questions.indexOf(question), newValue);
                            });
                          },
                          isFieldValid: questionFieldsValid[questionIndex],
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sección para seleccionar imágenes, antes del botón de envío
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: pickImages,
                        child: const Text('Seleccionar Imágenes'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  buildImagePreview(),

                  const SizedBox(height: 24),

                  // Botón de envío
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_isFormValid()) {
                          try {
                            // Obtener las respuestas del formulario
                            final answers = controller.getSelectedAnswers();

                            // Cargar las fuentes NotoSans desde la raíz
                            final regularFont =
                            pw.Font.ttf(await rootBundle.load('NotoSans-Regular.ttf'));
                            final boldFont =
                            pw.Font.ttf(await rootBundle.load('NotoSans-Bold.ttf'));

                            // Crear un PDF
                            final pdf = pw.Document();

                            // Agregar contenido al PDF
                            pdf.addPage(
                              pw.Page(
                                build: (pw.Context context) {
                                  return pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Análisis de Trabajo Seguro (AST)',
                                        style: pw.TextStyle(font: boldFont, fontSize: 20),
                                      ),
                                      pw.SizedBox(height: 16),
                                      pw.Text(
                                        'Área o Sector Físico: ${areaController.text}',
                                        style: pw.TextStyle(font: regularFont),
                                      ),
                                      pw.Text(
                                        'Correo del Trabajador: ${trabajadorEmailController.text}',
                                        style: pw.TextStyle(font: regularFont),
                                      ),
                                      pw.Text(
                                        'Correo del Supervisor: ${supervisorEmailController.text}',
                                        style: pw.TextStyle(font: regularFont),
                                      ),
                                      pw.SizedBox(height: 16),
                                      pw.Text(
                                        'Respuestas a las preguntas:',
                                        style: pw.TextStyle(font: boldFont),
                                      ),
                                      ...answers.entries.map(
                                            (entry) => pw.Text(
                                          '${entry.key}: ${entry.value}',
                                          style: pw.TextStyle(font: regularFont),
                                        ),
                                      ),
                                      pw.SizedBox(height: 16),
                                      pw.Text(
                                        'Imágenes seleccionadas:',
                                        style: pw.TextStyle(font: boldFont),
                                      ),
                                      ...selectedImages.map((image) {
                                        final imageFile = pw.MemoryImage(
                                          File(image.path).readAsBytesSync(),
                                        );
                                        return pw.Image(imageFile, height: 100, width: 100);
                                      }),
                                    ],
                                  );
                                },
                              ),
                            );

                            // Obtener la ubicación de Descargas
                            final directory = await getExternalStorageDirectory();
                            final downloadDir = Directory('${directory!.parent.parent.parent.parent.path}/Download');
                            if (!downloadDir.existsSync()) {
                              downloadDir.createSync();
                            }
                            final filePath = '${downloadDir.path}/AST_Formulario.pdf';

                            // Guardar el PDF localmente
                            final file = File(filePath);
                            await file.writeAsBytes(await pdf.save());

                            // Notificación al usuario
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('PDF guardado en Descargas: $filePath')),
                            );

                            print("PDF creado. Archivo guardado en $filePath");
                          } catch (e) {
                            print("Error al generar el PDF: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ocurrió un error al generar el PDF')),
                            );
                          }
                        } else {
                          // Si no es válido, mostrar un mensaje
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Por favor, rellene todos los campos')),
                          );
                        }
                      },
                      child: const Text('Enviar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
