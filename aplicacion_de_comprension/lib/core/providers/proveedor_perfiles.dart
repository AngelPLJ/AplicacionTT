import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'proveedor.dart';
import '../../features/usuario/entidades/perfil.dart';

final profilesStreamProvider = StreamProvider<List<Perfil>>((ref) =>
  ref.read(repoPerfilProvider).mirarPerfiles());