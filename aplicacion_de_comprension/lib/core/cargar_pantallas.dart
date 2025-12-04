import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'proveedor.dart';

enum BootRoute {introduccion, onboarding, login, profiles, mainMenu }

const kOnboardingSeenKey = 'onboarding_seen_v1';

final bootProvider = FutureProvider<BootRoute>((ref) async {
  final ownerRepo = ref.read(repoTutorProvider);
  final exists = await ownerRepo.existeTutor();
  final prefs = await ref.watch(prefsProvider.future);
  final seen = prefs.getBool(kOnboardingSeenKey) ?? false;
  if (!seen)  {
    return BootRoute.introduccion;
  } else if (!exists) {
    return BootRoute.onboarding;
  }
  final quick = await ownerRepo.sesionRapidaActiva();
  if (!quick) return BootRoute.login;

  final perfilRepo = ref.read(repoPerfilProvider);
  final activeProfile = await perfilRepo.getActivo();

  if (activeProfile != null) {
    return BootRoute.mainMenu;
  } else {
    return BootRoute.profiles;
  }
});
