import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/proveedor.dart';

enum BootRoute {introduccion, onboarding, login, profiles }

const kOnboardingSeenKey = 'onboarding_seen_v1';

final bootProvider = FutureProvider<BootRoute>((ref) async {
  final ownerRepo = ref.read(repoTutorProvider);
  final exists = await ownerRepo.existeTutor();
  final prefs = await ref.watch(prefsProvider.future);
  final seen = prefs.getBool(kOnboardingSeenKey) ?? false;
  if (!seen) return BootRoute.introduccion;
  if (!exists) return BootRoute.onboarding;
  final quick = await ownerRepo.sesionRapidaActiva();
  return quick ? BootRoute.profiles : BootRoute.login;
});
