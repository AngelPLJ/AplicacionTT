import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplicacion_de_comprension/core/utils/tts_helper.dart';
import 'package:aplicacion_de_comprension/features/actividades/presentacion/proveedor_actividades.dart';
import '../../../core/utils/prefs_provider.dart'; 
import '../../tutor/presentacion/proveedor_tutor.dart'; 

enum BootRoute { introduccion, onboarding, login, profiles, mainMenu }

const kOnboardingSeenKey = 'onboarding_seen_v1';

final appInitProvider = FutureProvider<void>((ref) async {
  await Future.wait([
    ref.read(ttsHelperProvider).init(),
    ref.read(repoContenidoProvider).poblarBaseDeDatos(),
    Future.delayed(const Duration(seconds: 2)),
  ]);
});

final bootProvider = FutureProvider<BootRoute>((ref) async {
  
  await ref.watch(appInitProvider.future);

  final ownerRepo = ref.read(repoTutorProvider);
  final perfilRepo = ref.read(repoPerfilProvider);
  final prefs = await ref.watch(prefsProvider.future); 

  final seen = prefs.getBool(kOnboardingSeenKey) ?? false;
  if (!seen) return BootRoute.introduccion;

  final exists = await ownerRepo.existeTutor();
  if (!exists) return BootRoute.onboarding;

  final quick = await ownerRepo.sesionRapidaActiva();
  if (!quick) return BootRoute.login;

  final activeProfile = await perfilRepo.getActivo();
  if (activeProfile != null) {
    return BootRoute.mainMenu;
  } else {
    return BootRoute.profiles;
  }
});