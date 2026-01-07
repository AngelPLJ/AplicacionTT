// modelo_introduccion.dart
class IntroduccionDatos {
  final String title;
  final String text;

  const IntroduccionDatos({
    required this.title,
    required this.text,
  });
}

// Lista de datos estática
final List<IntroduccionDatos> datosIntroduccion = const [
  IntroduccionDatos(
    title: 'Bienvenid@',
    text: 'Aplico es una aplicación educativa creada para fortalecer la comprensión lectora en estudiantes de primaria.',
  ),
  IntroduccionDatos(
    title: 'La lectura',
    text: 'La lectura no solo implica reconocer palabras, sino también dar sentido a los textos. Para lograrlo, se utilizan cuatro habilidades clave:',
  ),
  IntroduccionDatos(
    title: 'Atención',
    text: 'Mantener el foco en el texto, ignorar distracciones, seleccionar información relevante.',
  ),
  IntroduccionDatos(
    title: 'Memoria',
    text: 'Retener e integrar información leída para construir significado en tiempo real.',
  ),
  IntroduccionDatos(
    title: 'Lógica',
    text: 'Ordenar ideas, identificar relaciones causa-efecto, seguir secuencias narrativas.',
  ),
  IntroduccionDatos(
    title: 'Y la inferencia',
    text: 'Deducir significados no explícitos, anticipar contenidos y activar conocimientos previos.',
  ),
  IntroduccionDatos(
    title: 'Diviertete',
    text: 'Cada actividad dentro de la aplicación está diseñada para estimular estas habilidades esperamos que la disfrutes.',
  ),
];