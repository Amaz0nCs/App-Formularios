import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'form_selection_screen.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _formKey = GlobalKey<FormState>();
  String? correo;
  String? password;

  // Función de login
  Future<void> login(String correo, String password) async {
    final url = Uri.parse('http://10.0.2.2/login.php');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'correo': correo,
          'password': password,
        }),
      );

      print("Cuerpo de la respuesta: ${response.body}");

      if (response.statusCode == 200) {
        try {
          // Verificar si la respuesta es un JSON válido
          final data = jsonDecode(response.body);

          if (data['success']) {
            // Si el login es exitoso, extrae los datos
            String patente = data['patente'] ?? '';
            String supervisor = data['supervisor'] ?? '';
            String jornada = data['jornada'] ?? '';
            String correoTrabajador = data['correo_trabajador'] ?? '';
            String correoSupervisor = data['supervisor_email'] ?? '';


            // Navega a la pantalla de selección de formulario
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FormSelectionScreen(
                  patente: patente,
                  supervisor: supervisor,
                  jornada: jornada,
                  correo: correo,
                  correoTrabajador: correoTrabajador,
                  correoSupervisor: correoSupervisor,
                ),
              ),
            );
          } else {
            // Si no es exitoso, muestra el mensaje del servidor
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'] ?? 'Error desconocido')),
            );
          }
        } catch (e) {
          print("Error al procesar la respuesta JSON: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al procesar la respuesta del servidor')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error de conexión con el servidor')),
        );
      }
    } catch (e) {
      print("Error al intentar conectarse: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al intentar conectarse: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E225B),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Parte superior con la imagen
              Container(
                height: constraints.maxHeight * 0.4, // Parte superior ocupa el 40% de la pantalla
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'ctr-logo.png', // Ruta del logo
                        width: MediaQuery.sizeOf(context).width * 0.7, // 70% del ancho de la pantalla
                        height: double.infinity,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment(1, -1),
                      ),
                    ),
                  ),
                ),
              ),
              // Parte inferior con el formulario
              Container(
                height: constraints.maxHeight * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Accede a tu cuenta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Bitácora camioneta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ingresa tu Correo',
                          labelStyle: const TextStyle(color: Color(0xFF000000)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(
                                0xFF1E225B), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            correo = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el correo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: const TextStyle(color: Color(0xFF000000)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(
                                0xFF1E225B), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Centramos el botón de inicio de sesión
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              login(correo!, password!);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E225B),
                            side: const BorderSide(color: Color(0xFFFFFFFF), width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          ),
                          child: const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
