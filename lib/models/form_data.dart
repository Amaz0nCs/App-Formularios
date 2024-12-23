class FormData {
  String? fecha;
  String? hora;
  String? jornada;
  String? destinoActividad;
  String? patente;
  String? kilometraje;
  String? correo;
  String? direccion;
  String idArea;

  FormData({
    this.fecha,
    this.hora,
    this.jornada,
    this.destinoActividad,
    this.patente,
    this.kilometraje,
    this.correo,
    this.direccion,
    this.idArea = '1',
  });

  Map<String, dynamic> toJson() {
    return {
      'fecha': fecha ?? '',
      'hora': hora ?? '',
      'jornada': jornada ?? '',
      'destino': destinoActividad ?? '',
      'patente': patente ?? '',
      'kilometraje': kilometraje ?? '',
      'correo': correo ?? '',
      'direccion': direccion ?? '',
      'id_area': idArea,
    };
  }
}
