import 'package:flutter/material.dart';
import 'form_screen.dart';

class FormSelectionScreen extends StatelessWidget {
  final String patente;
  final String supervisor;
  final String jornada;

  const FormSelectionScreen({
    super.key,
    required this.patente,
    required this.supervisor,
    required this.jornada,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco
        elevation: 0, // Elimina la sombra del AppBar
        iconTheme: const IconThemeData(color: Colors.black), // Iconos en negro
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'Logo-CTR1.png',
            fit: BoxFit.cover, // Asegura que la imagen se ajuste sin distorsionarse
            width: 250, // Agrandamos más el logo
            height: 250, // Ajusta la altura también
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Título y subtítulo alineados a la izquierda
          children: [
            // Título y subtítulo alineados a la izquierda debajo del AppBar
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

            // Centrar los botones
            Center(
              child: Column(
                children: [
                  // Botón 1
                  SizedBox(
                    width: double.infinity, // Asegura que todos los botones tengan el mismo ancho
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegar al formulario de bitácora y pasar los datos
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(
                              patente: patente,
                              supervisor: supervisor,
                              jornada: jornada,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E225B),
                        padding: const EdgeInsets.symmetric(vertical: 16.0), // Aumento del padding vertical
                      ),
                      child: const Text(
                        'Formulario de Bitácora',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Botón 2
                  SizedBox(
                    width: double.infinity, // Asegura que todos los botones tengan el mismo ancho
                    child: ElevatedButton(
                      onPressed: () {
                        // Agrega la lógica para otro formulario
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Formulario aún no implementado')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E225B),
                        padding: const EdgeInsets.symmetric(vertical: 16.0), // Aumento del padding vertical
                      ),
                      child: const Text(
                        'Formulario del ejemplo',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Botón 3
                  SizedBox(
                    width: double.infinity, // Asegura que todos los botones tengan el mismo ancho
                    child: ElevatedButton(
                      onPressed: () {
                        // Agrega la lógica para otro formulario
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Formulario aún no implementado')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E225B),
                        padding: const EdgeInsets.symmetric(vertical: 16.0), // Aumento del padding vertical
                      ),
                      child: const Text(
                        'Formulario del ejemplo la secuela',
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
