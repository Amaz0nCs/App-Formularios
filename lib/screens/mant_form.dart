import 'package:flutter/material.dart';
import 'package:prueba/screens/form_screen.dart';


class MantForm extends StatelessWidget {
  final TextEditingController patenteController = TextEditingController();
  final TextEditingController kilometrajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // Elimina la flecha de retroceso
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),  // Eliminar padding para mover el logo hacia la izquierda
          child: Image.asset(
            'Logo-CTR1.png',
            width: 80,  // Ajusta el tamaño del logo aquí
            height: 80,  // Ajusta el tamaño del logo aquí
          ),
        ),

        actions: [
          // Botón de Bitácora
          TextButton(
            onPressed: () {
              // Navegar a la pantalla de Bitacora
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()), // Navega a FormScreen (Bitácora)
              );
            },
            child: Text(
              'Bitacora',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          // Botón de Mantenimiento (ya estamos en esta pantalla, no hacemos nada)
          TextButton(
            onPressed: () {

            },
            child: Text(
              'Mantenimiento',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulario de Mantenimiento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Campo de Patente
            TextField(
              controller: patenteController,
              decoration: InputDecoration(
                labelText: 'Ingrese la Patente',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Campo de Kilometraje
            TextField(
              controller: kilometrajeController,
              keyboardType: TextInputType.number, // Solo números para el kilometraje
              decoration: InputDecoration(
                labelText: 'Ingrese el Kilometraje',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Botón para consultar mantenimiento
                ElevatedButton(
                  onPressed: () {
                    // Acción para consultar el mantenimiento
                    String patente = patenteController.text;
                    String kilometraje = kilometrajeController.text;
                    print("Consultando mantenimiento de $patente con kilometraje $kilometraje");

                  },
                  child: Text('Consultar Mantenimiento'),
                ),

                // Botón para registrar mantenimiento
                ElevatedButton(
                  onPressed: () {

                    String patente = patenteController.text;
                    String kilometraje = kilometrajeController.text;
                    print("Registrando mantenimiento de $patente con kilometraje $kilometraje");

                  },
                  child: Text('Registrar Mantenimiento'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
