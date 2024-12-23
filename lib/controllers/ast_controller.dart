import '../models/question_model.dart';  // Importa el modelo de preguntas

class AstController {
  // Aquí defines las preguntas como propiedades del controlador
  List<QuestionModel> questions = [
    // Pregunta sobre actividades a realizar
    QuestionModel(
      text: '1. Actividades a realizar (Seleccione las actividades):',
      options: [
        'Conducción de vehículos',
        'Trabajo en altura física',
        'Actividades nocturnas',
        'Trabajos en espacios confinados',
        'Trabajos en caliente y uso de herramientas eléctricas',
        'Trabajos a nivel de piso'
      ],
    ),
    // Pregunta sobre inspección y conducción de vehículos
    QuestionModel(
      text: '2. Inspección y conducción de vehículos:',
      options: [
        'La bitácora de uso del vehículo se encuentra vigente',
        'Los neumáticos del vehículo están en buenas condiciones y con la presión adecuada',
        'Se cuenta con licencia adecuada y vigente para conducir el vehículo',
        'La documentación del vehículo se encuentra vigente (revisión técnica, permiso de circulación, seguros)',
        'El vehículo cuenta con los elementos básicos de seguridad (extintor, triángulo, chaleco, etc.)',
        'Se verifica que no haya elementos sueltos en la cabina',
        'El nivel de combustible está verificado',
        'La carrocería del vehículo está en buenas condiciones',
        'El conductor cuenta con capacitación en conducción defensiva o 4x4',
        'Se han identificado, evaluado y controlado los riesgos antes de la operación',
        'Las luces (altas, bajas, virajes) están en buenas condiciones',
        'El vehículo tiene las herramientas básicas (gato, rueda de repuesto, triángulo, etc.)',
        'El conductor está en buenas condiciones de salud (sin tratamientos médicos ni medicamentos)',
        'El conductor tiene examen psicotécnico',
        'Los espejos del vehículo están en buenas condiciones',
        'El conductor fue capacitado en normas de seguridad internas y procedimientos de conducción'
      ],
    ),
    // Pregunta sobre actividades nocturnas
    QuestionModel(
      text: '3. Actividades nocturnas:',
      options: [
        'El personal está en buenas condiciones físicas',
        'El personal cumple con sus horas de descanso y no presenta somnolencia',
        'El personal no está tomando medicamentos que interfieran con su capacidad de trabajo',
        'El personal tiene capacitación para realizar las actividades'
      ],
    ),
    // Pregunta sobre trabajos en espacios confinados
    QuestionModel(
      text: '4. Trabajos en espacios confinados:',
      options: [
        'El trabajador tiene capacitación y entrenamiento para trabajos en espacios confinados',
        'El trabajador tiene examen vigente de altura física y espacios confinados',
        'Se cuenta con supervisión directa (jefatura, supervisor, prevencionista)',
        'El trabajador conoce los procedimientos de seguridad en espacios confinados',
        'Los equipos antiácidas están certificados y en buenas condiciones',
        'Los EPP están en buenas condiciones y con fecha de vencimiento vigente',
        'Se demarca el área de trabajo con conos y cinta de peligro',
        'Se ventila la cámara por un mínimo de 30 minutos',
        'Los equipos de medición de voltaje están en buenas condiciones',
        'Se evalúa la fuga de energía antes de las actividades',
        'Se evalúa la presencia de gases peligrosos',
        'Se utiliza máscara de gases ácidos/orgánicos o respiración autónoma (ERA)',
        'El espacio de trabajo está seco, sin humedad',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        'Se prohíbe fumar o encender fuego en el área de trabajo',
        'Se utilizan elementos dieléctricos (mantas, guantes) para trabajos con riesgo eléctrico',
        'Se prohíbe el uso de elementos metálicos como joyas, relojes, pulseras, anillos',
        'El personal está en buenas condiciones de salud (sin tratamientos médicos ni medicamentos)',
        'Se han identificado, evaluado y controlado todos los riesgos antes de iniciar'
      ],
    ),
    // Pregunta sobre trabajos en altura física
    QuestionModel(
      text: '5. Trabajos en altura física:',
      options: [
        'El trabajador tiene capacitación y entrenamiento en procedimientos de trabajo seguro (PTS)',
        'El trabajador tiene examen de altura física vigente',
        'Los equipos antiácidas están certificados y en buenas condiciones',
        'Se cuenta con supervisión directa para realizar las tareas',
        'Los puntos de anclaje y líneas de vida están verificados y son seguros',
        'El casco de seguridad tiene barbuquejo',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        'Los EPP están en buenas condiciones y con fecha de vencimiento vigente',
        'El personal está en buenas condiciones de salud',
        'Se han identificado, evaluado y controlado todos los riesgos previos a la operación',
        'Las condiciones climáticas son favorables para la actividad'
      ],
    ),
    // Pregunta sobre trabajos en postaciones de hormigón y madera
    QuestionModel(
      text: '6. Trabajos en postaciones de hormigón y madera:',
      options: [
        'El trabajador tiene capacitación y entrenamiento en procedimientos de trabajo seguro (PTS)',
        'El trabajador tiene examen de altura física vigente',
        'Los equipos antiácidas están certificados y en buenas condiciones',
        'Se cuenta con supervisión directa para realizar las tareas',
        'Los puntos de anclaje y líneas de vida están verificados y son seguros',
        'Las condiciones climáticas son favorables para la actividad',
        'El casco de seguridad tiene barbuquejo',
        'Se han evaluado los riesgos de energía eléctrica antes de la operación',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        'Los EPP están en buenas condiciones y con fecha de vencimiento vigente',
        'El personal está en buenas condiciones de salud',
        'Se han identificado, evaluado y controlado todos los riesgos antes de la operación',
        'Se inspecciona visualmente el estado estructural del poste',
        'Se realizan pruebas manuales de empuje y resistencia al poste'
      ],
    ),
    QuestionModel(
      text: '7. Trabajos generales en distintos lugares geográficos dentro del territorio nacional / Mantención de sitios:',
      options: [
        'Personal cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS exposición a roedores en zonas rurales y silvestres) para realizar las actividades',
        'Trabajador conoce procedimiento de trabajo seguro para realizar la actividad (PTS operador motosierra y desbrozadora, PTS)',
        'Personal cuenta con entrenamiento y capacitación en uso de herramientas (motosierras)',
        'Trabajador posee todos los EPP para realizar labores de mantención en sitios (buzo desechable, mascarilla desechable, zapatos de seguridad, lentes de seguridad o careta facial, casco nivel de piso, cubre nuca, bloqueador solar factor 50, guantes de cabritilla)',
        'Se cuenta con medios de comunicación óptimos para la coordinación de tareas y avisos de emergencias',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas',
        'Personal cuenta con la ropa adecuada según las condiciones climáticas de la zona',
        'Se evalúa y controla la hidratación y alimentación necesaria según duración del proyecto o actividad',
        'Se informa del uso de bloqueador solar',
        'Se entrega un listado de trabajadores y la información necesaria a Carabinero, CONAF, Bomberos, etc.',
        'Se cuenta con botiquín de primeros auxilios para casos de emergencias',
        'Se mantienen los números telefónicos de emergencias actualizados',
        'Si se requiere utilizar transporte tales como motos 4x4 / de nieve o cualquier otro, el personal se encuentra capacitado',
        '¿El personal se encuentra en buenas condiciones de salud? (Sin tratamientos médicos e ingesta de medicamentos)',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '8. Uso general de escaleras portátiles:',
      options: [
        'Trabajador conoce procedimiento de trabajo seguro para realizar la actividad (PTS trabajo en postes y escaleras, PTS tendido de línea, etc.)',
        'Trabajador cuenta con examen de altura física al día emitido por organismo administrador',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        '¿Los equipos antiácidas se encuentran certificados y en buenas condiciones? (Aplicar check list arnés)',
        'Escalera se encuentra en buen estado y con fecha de vencimiento al día',
        'Condiciones climáticas son favorables para realizar la actividad? (Vientos menores a 30 km/h. - Ausencia de lluvia y nieve)',
        'El estado estructural del poste (de madera o cemento) se encuentra en buenas condiciones para apoyar escalera telescópica',
        'Se posiciona escalera en un ángulo de 70 grados',
        'El personal se encuentra en buenas condiciones de salud',
        'Se amarra escalera a lugar de apoyo (poste, techumbre, etc.)',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '9. Trabajos en caliente / Y uso de herramientas eléctricas:',
      options: [
        'Personal cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS) para realizar las actividades (Curso de soldador, uso de herramientas de corte y esmerilado, etc.)',
        'Trabajador posee certificación en soldadura',
        'Se cuenta con máscara de soldar apropiada',
        'Trabajador posee todos los EPP y vestimenta adecuada para realizar trabajos en caliente (zapatos de seguridad, casco, guantes, lentes de protección o careta facial, traje de cuero)',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas',
        'Las herramientas eléctricas a utilizar se encuentran en buen estado y con todas sus protecciones',
        'El área de trabajo cuenta con sistemas de extinción de incendio',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        '¿El personal se encuentra en buenas condiciones de salud? (Sin tratamientos médicos e ingesta de medicamentos)',
        'El área de trabajo está despejada de material combustible',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '10. Uso de herramientas manuales:',
      options: [
        'Trabajador conoce procedimiento de trabajo seguro para realizar la actividad (PTS de trabajos con herramientas manuales)',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        'Se cuenta con todos los EPP adecuados para realizar las actividades',
        'Las herramientas eléctricas a utilizar se encuentran en buen estado',
        'La superficie de trabajo donde se realizará el trabajo, es seguro',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '11. Trabajos en tableros eléctricos o cables energizados:',
      options: [
        'Trabajador posee acreditación (Curso de riesgos eléctricos y certificación)',
        'Trabajador conoce procedimiento de trabajo seguro para realizar la actividad (PTS riesgos eléctricos)',
        'Trabajador posee todos los EPP para realizar trabajos con exposición a electricidad',
        'Los EPP y herramientas a utilizar son dieléctricas (zapatos de seguridad dieléctricos, casco dieléctrico, guantes de seguridad dieléctricos, etc.)',
        'Las herramientas a utilizar son dieléctricas',
        '¿Las herramientas dieléctricas a utilizar se encuentran con respectiva aislamiento y en buen estado? (Sin piquetes en protección dieléctrica)',
        'Se han evaluado los riesgos de energía eléctrica antes de realizar la operación',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        '¿Los EPP para realizar la actividad, se encuentran en buenas condiciones y con fecha de vencimiento vigente? (Aplicar check list EPP)',
        'Se prohíbe realizar trabajos en presencia de lluvia o humedad en el lugar',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '12. Uso de herramientas de corte (desmalezadora, motosierra):',
      options: [
        'Trabajador cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS) para realizar las actividades',
        'Trabajador posee acreditación (Curso de riesgos en uso de desmalezadora y motosierra)',
        'Trabajador conoce procedimiento de trabajo seguro para realizar la actividad (PTS desmalezadora, motosierra)',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas',
        'Se realiza una inspección visual antes de las herramientas a utilizar',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        '¿El personal se encuentra en buenas condiciones de salud? (Sin tratamientos médicos e ingesta de medicamentos)',
        'Las herramientas a utilizar se encuentran en buen estado y con respectivas protecciones',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones'
      ],
    ),
    QuestionModel(
      text: '13. Carga y descarga de materiales:',
      options: [
        'Trabajador posee capacitación en manejo manual de carga (Curso MMC)',
        '¿Los EPP se encuentran en buenas condiciones y certificados? (Aplicar check list EPP)',
        'Las herramientas o equipos mecánicos o eléctricos para manipular cargas se encuentran en buen estado y con todas sus protecciones?',
        'Personal se encuentra capacitado para la manipulación de herramientas mecánicas de carga?',
        'Si el trabajo es en la intemperie se establecen las medidas de seguridad (hidratación, bloqueador solar y vestimenta adecuada)',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        '¿El personal se encuentra en buenas condiciones de salud? (Sin tratamientos médicos e ingesta de medicamentos)',
        'Se cuenta con supervisión directa por jefatura o supervisor de turno para realizar las tareas?',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones?'
      ],
    ),
    QuestionModel(
      text: '14. Trabajos en azotea de edificios:',
      options: [
        'Trabajador cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS) para realizar las actividades?',
        'Trabajador cuenta con examen de altura física al día emitido por organismo administrador?',
        '¿Los equipos antiácidas se encuentran certificados y en buenas condiciones? (Aplicar check list arnés)',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas?',
        'Se han verificado que los puntos de anclaje y líneas de vida sean seguras?',
        'Casco de seguridad cuenta con barbijuejo?',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        '¿Los EPP para realizar la actividad, se encuentran en buenas condiciones y con fecha de vencimiento vigente? (Aplicar check list EPP)',
        '¿El personal se encuentra en buenas condiciones de salud? (Sin tratamientos médicos e ingesta de medicamentos)',
        'Las condiciones climáticas son favorables para realizar la actividad? (Vientos menores a 30 km/h. - Ausencia de lluvia y nieve)',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones?'
      ],
    ),
    QuestionModel(
      text: '15. Izaaje de materiales / Cargas en suspensión:',
      options: [
        'Trabajador cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS) para realizar las actividades?',
        'Se cuenta con un plan previo de izaje?',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas?',
        '¿Condiciones climáticas son favorables para realizar la actividad? (Vientos menores a 30 km/h. - Ausencia de lluvia y nieve)',
        'Se cuenta con rigger calificado?',
        'Operadores de grúas y maquinarias de carga se encuentran certificados?',
        'Maquinarias de carga se encuentran con documentación vigente?',
        'Las herramientas a utilizar se encuentran certificadas y en buenas condiciones (eslingas, estrobos, cadenas, teclas, etc.)',
        'Se verifica la estabilización de equipos y cargas?',
        'Se verifican los cables de izaje, ganchos y seguros en buenas condiciones?',
        'Para la guía de la carga, se verifican que los vientos estén en buenas condiciones y el personal capacitado para efectuar la maniobra?'
      ],
    ),
    QuestionModel(
      text: '16. Verificación y control de carga y descarga de combustible:',
      options: [
        'Trabajador cuenta con entrenamiento y capacitación de procedimientos de trabajo seguro (PTS) y planes de emergencias para realizar las actividades?',
        'Se posiciona correctamente el camión o la unidad de descarga?',
        'Se establece un perímetro seguro y señalización del área de trabajo',
        'Se cuenta con supervisión directa de jefatura, supervisor o prevencionista para realizar las tareas?',
        '¿Existe prohibición de fumar y encender algún tipo de fuego en el área de trabajo?',
        'El área de trabajo cuenta con sistemas de extinción de incendio?',
        'Se cuenta con plan de emergencia frente a derrames?',
        'Se cuenta con kit anti derrame o baldes de arena para contener un posible derrame?',
        'Se evalúan las mediciones de niveles del tanque antes de la descarga?',
        'Se han identificado, evaluado y controlado todos los riesgos previos al inicio de las operaciones?'
      ],
    ),
    QuestionModel(
      text: '17. Seleccione los EPP a utilizar:',
      options: [
        'Casco de seguridad con barbijuejo',
        'Guantes de seguridad',
        'Zapatos de seguridad',
        'Lentes o antiparras de seguridad',
        'Careta facial',
        'Coleto de cuero',
        'Fonos auditivos',
        'Arnés de seguridad certificado',
        'Cola de vida para anclaje',
        'Bloqueador solar',
        'Respirador filtro según agentes ambientales',
        'Instrumentos de medición de gases',
        'Manta dieléctrica',
        'Botas dieléctricas',
        'Evaluación de voltaje',
        'Otros'
      ],
    ),
    QuestionModel(
      text: '18. Seleccione las herramientas a utilizar:',
      options: [
        'Taladro',
        'Angular',
        'Tester',
        'Alicates',
        'Martillos',
        'Atornillador',
        'Escalera',
        'Andamio',
        'Otros'
      ],
    ),
    QuestionModel(
      text: '19. Doy fe que las herramientas, equipos y EPP se encuentran en perfectas condiciones y cumplen con los estándares de seguridad correspondientes.',
      options: [
        'Sí',
        'No'
      ],
    ),
    QuestionModel(
      text: '20. Según AST, la actividad se puede realizar de manera segura',
      options: [
        'Sí (Se ejecuta)',
        'No (No se ejecuta)'
      ],
    ),

    QuestionModel(
      text: '21. Empresa que realiza la maniobra:',
      options: [
        'CTR Telefonía Rural',
        'FOA',
        'Externa'
      ],
      textInput: 'Si selecciona "Externa", ingrese el nombre de la empresa externa:',
    ),
  ];

  //metodos

  // Método para obtener las respuestas seleccionadas
  Map<String, List<String>> getSelectedAnswers() {
    Map<String, List<String>> answers = {};
    for (var i = 0; i < questions.length; i++) {
      // Si hay respuestas seleccionadas, las agrega como una lista
      if (questions[i].selectedOptions.isNotEmpty) {
        answers['Pregunta ${i + 1}'] = questions[i].selectedOptions;
        if (questions[i].textInput != null &&
            questions[i].textInput!.isNotEmpty) {
          // Si tiene un campo de texto (ej. "Otro"), agregarlo también
          answers['Pregunta ${i + 1} (Texto)'] = [questions[i].textInput!];
        }
      }
    }
    return answers;
  }

  void updateAnswer(int index, String option, {String? textInput}) {
    final question = questions[index];

    if (question.allowsMultipleSelection) {
      // Si la opción ya está seleccionada, la quitamos de la lista
      if (question.selectedOptions.contains(option)) {
        question.selectedOptions.remove(option);
      } else {
        // Si no está seleccionada, la agregamos a la lista
        question.selectedOptions.add(option);
      }
    } else {
      // Si no permite selección múltiple, reemplazamos la selección anterior
      question.selectedOptions = [option];
    }

    // Si la opción seleccionada es "Otro", activamos el campo de texto
    if (option == 'Otro') {
      question.textInput = textInput;
    } else {
      question.textInput = null; // Borramos el campo de texto si no es "Otro"
    }
  }
}