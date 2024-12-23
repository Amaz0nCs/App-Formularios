import 'package:flutter/material.dart';
import 'package:prueba/screens/ast_form.dart';
import 'package:prueba/screens/form_screen.dart';

class FormSelectionScreen extends StatelessWidget {
  final String patente;
  final String supervisor;
  final String jornada;
  final String correo;
  final String correoTrabajador;
  final String correoSupervisor;


  const FormSelectionScreen({
    super.key,
    required this.patente,
    required this.supervisor,
    required this.jornada,
    required this.correo,
    required this.correoTrabajador,
    required this.correoSupervisor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Formularios CTR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Seleccionar Formulario',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(
                              patente: patente,
                              supervisor: supervisor,
                              jornada: jornada,
                              correo: correo,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E225B),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Formulario de Bitácora',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegar a AstFormScreen pasando los correos
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AstFormScreen(
                              correoTrabajador: correoTrabajador,
                              correoSupervisor: correoSupervisor,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E225B),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Formulario(AST)-FOR-SST-02',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
