class QuestionModel {
  String text; // Texto de la pregunta (todo esto es de AST)
  List<String> options; // Opciones para la pregunta
  List<String> selectedOptions = []; // Opciones seleccionadas
  String? textInput; // Campo de texto adicional, si corresponde (nullable)
  bool allowsMultipleSelection; // Permitir selección múltiple
  bool hasTextInput; // Indicar si la pregunta requiere texto adicional

  // Constructor
  QuestionModel({
    required this.text,
    required this.options,
    this.textInput,
    this.allowsMultipleSelection = true,
    this.hasTextInput = false,
  });
}
