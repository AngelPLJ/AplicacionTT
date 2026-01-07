String obtenerFondoEstacion() {
  final mes = DateTime.now().month;

  // Primavera: Marzo (3), Abril (4), Mayo (5)
  if (mes >= 3 && mes <= 5) {
    return 'assets/imagenes/primavera.jpg';
  }
  
  // Verano: Junio (6), Julio (7), Agosto (8)
  else if (mes >= 6 && mes <= 8) {
    return 'assets/imagenes/verano.jpg';
  }
  
  // Otoño: Septiembre (9), Octubre (10), Noviembre (11)
  else if (mes >= 9 && mes <= 11) {
    return 'assets/imagenes/otono.jpg';
  }
  
  // Invierno: Diciembre (12), Enero (1), Febrero (2)
  else {
    return 'assets/imagenes/invierno.jpg';
  }
}