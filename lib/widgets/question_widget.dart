import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionWidget extends StatefulWidget {
  final QuestionModel question;
  final Function(String, String?) onChanged;
  final bool isFieldValid;

  const QuestionWidget({super.key,
    required this.question,
    required this.onChanged,
    required this.isFieldValid,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.question.selectedOptions.isNotEmpty
        ? widget.question.selectedOptions.first
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            widget.question.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          // Verificamos si la pregunta debe ser de tipo Radio (selección única)
          if (widget.question.text == '1. Actividades a realizar (Seleccione las actividades):')
            ...widget.question.options.map<Widget>((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _groupValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _groupValue = value;
                    });
                    widget.onChanged(value, null);
                  }
                },
              );
            }), // Convertimos el iterable en una lista

          // Pregunta con borde rojo si no está seleccionada
          if (widget.question.text == '19. Doy fe que las herramientas, equipos y EPP se encuentran en perfectas condiciones y cumplen con los estándares de seguridad correspondientes.')
            ...[
              // Mostrar solo una opción de Radio para "Sí" y "No" en un solo grupo
              RadioListTile<String>(
                title: const Text('Sí'),
                value: 'Sí',
                groupValue: _groupValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _groupValue = value;  // Actualizamos el valor seleccionado
                    });
                    widget.onChanged(value, null);  // Actualizamos el estado en el modelo
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('No'),
                value: 'No',
                groupValue: _groupValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _groupValue = value;  // Actualizamos el valor seleccionado
                    });
                    widget.onChanged(value, null);  // Actualizamos el estado en el modelo
                  }
                },
              ),
            ],

          if (widget.question.text == '20. Según AST, la actividad se puede realizar de manera segura')
            ...widget.question.options.map<Widget>((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _groupValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _groupValue = value;  // Actualizamos el valor seleccionado
                    });
                    widget.onChanged(value, null);  // Actualizamos el estado en el modelo
                  }
                },
              );
            }), // Convertimos el iterable en una lista

          // Agregar la validación de borde rojo si no está seleccionado
          if (widget.question.text == '21. Empresa que realiza la maniobra:')
            ...widget.question.options.map<Widget>((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _groupValue,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _groupValue = value;  // Actualizamos el valor seleccionado
                    });

                    // Si la opción seleccionada es "Externa"
                    if (value == "Externa") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController textController = TextEditingController();
                          return AlertDialog(
                            title: const Text('Escribe el nombre de la empresa externa'),
                            content: TextField(
                              controller: textController,
                              decoration: const InputDecoration(hintText: 'Nombre de la empresa'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  widget.onChanged(value, textController.text);  // Pasamos la opción y el texto ingresado
                                  Navigator.pop(context);

                                  // Luego de ingresar el texto, aseguramos que "Externa" siga seleccionada
                                  setState(() {
                                    _groupValue = "Externa";  // Aquí mantienes la selección de "Externa"
                                  });
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      widget.onChanged(value, null); // Si no es "Externa", solo pasamos la opción
                    }
                  }
                },
              );
            }), // Convertimos el iterable en una lista

          // Validación para otras preguntas con opciones
          if (widget.question.text != '1. Actividades a realizar (Seleccione las actividades):' &&
              widget.question.text != '19. Doy fe que las herramientas, equipos y EPP se encuentran en perfectas condiciones y cumplen con los estándares de seguridad correspondientes.' &&
              widget.question.text != '20. Según AST, la actividad se puede realizar de manera segura' &&
              widget.question.text != '21. Empresa que realiza la maniobra:')
            ...widget.question.options.map<Widget>((option) {
              return CheckboxListTile(
                title: Text(option),
                value: widget.question.selectedOptions.contains(option),
                onChanged: (bool? value) {
                  if (value == true) {
                    // Si la opción seleccionada es "Externa", permitir que el usuario ingrese un texto adicional
                    if (option == "Externa") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController textController = TextEditingController();
                          return AlertDialog(
                            title: const Text('Escribe el nombre de la empresa externa'),
                            content: TextField(
                              controller: textController,
                              decoration: const InputDecoration(hintText: 'Nombre de la empresa'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  widget.onChanged(option, textController.text); // Pasamos la opción y el texto ingresado
                                  Navigator.pop(context);
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      widget.onChanged(option, null);  // Si no está seleccionada, pasamos la opción y null para el texto
                    }
                  } else {
                    widget.onChanged(option, null);  // Si no está seleccionada, pasamos la opción y null para el texto
                  }
                },
              );
            }), // Convertimos el iterable en una lista
        ],
      ),
    );
  }
}
