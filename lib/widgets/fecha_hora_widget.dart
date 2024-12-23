import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechaHoraWidget extends StatefulWidget {
  final String? fecha;
  final String? hora;

  const FechaHoraWidget({Key? key, this.fecha, this.hora}) : super(key: key);

  @override
  _FechaHoraWidgetState createState() => _FechaHoraWidgetState();
}

class _FechaHoraWidgetState extends State<FechaHoraWidget> {
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores pasados
    fechaController.text = widget.fecha ?? '';
    horaController.text = widget.hora ?? '';
  }

  // Función para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      fechaController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  // Función para mostrar el selector de hora
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      horaController.text = selectedTime.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo de Fecha
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                enabled: true, // Deshabilitar edición
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Campo de Hora
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: horaController,
                decoration: InputDecoration(
                  labelText: 'Hora',
                  border: OutlineInputBorder(),
                ),
                enabled: true, // Deshabilitar edición
              ),
            ),
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => _selectTime(context),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
