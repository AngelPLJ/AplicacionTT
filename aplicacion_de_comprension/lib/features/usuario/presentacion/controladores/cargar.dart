import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/proveedor.dart';

enum BootRoute { onboarding, login, profiles }

final bootProvider = FutureProvider<BootRoute>((ref) async {
  final ownerRepo = ref.read(repoTutorProvider);
  final exists = await ownerRepo.existeTutor();
  if (!exists) return BootRoute.onboarding;
  final quick = await ownerRepo.sesionRapidaActiva();
  return quick ? BootRoute.profiles : BootRoute.login;
});
