// domain/entities/family_settings.dart
class Configuracion {
  final String tutorId;
  final bool ttsHabilitado;
  final double ttsVelocidad;
  final bool musicaFondo;
  const Configuracion({required this.tutorId, required this.ttsHabilitado, required this.ttsVelocidad, required this.musicaFondo});
}