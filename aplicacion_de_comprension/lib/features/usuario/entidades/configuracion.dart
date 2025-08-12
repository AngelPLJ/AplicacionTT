// domain/entities/family_settings.dart
class Configuracion {
  final String tutorId;
  final bool ttsHabilitado;
  final double ttsFrecuencia;
  final double ttsTono;
  final bool parentalLock;
  const Configuracion({required this.tutorId, required this.ttsHabilitado, required this.ttsFrecuencia, required this.ttsTono, required this.parentalLock});
}