import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplicacion_de_comprension/core/providers/proveedor.dart'; 

import '../dominio/repositorios/repo_tutor.dart';
import '../dominio/repositorios/repo_perfil.dart';
import '../datos/repo_tutor_impl.dart';
import '../datos/repo_perfil_impl.dart';
import 'controladores/controlador_autenticacion.dart';
import 'estados/autenticacion.dart';
import '../dominio/entidades/perfil.dart';

final repoTutorProvider = Provider<RepoTutor>((ref) {
  final db = ref.watch(dbProvider); 
  final sec = ref.watch(secureStorageProvider); 
  final hasher = ref.watch(hasherProvider); 
  
  return RepoTutorImpl(db, sec, hasher);
});

final repoPerfilProvider = Provider<RepoPerfil>((ref) {
  final db = ref.watch(dbProvider);
  return ProfileRepositoryImpl(db);
});

final perfilActivoProvider = FutureProvider.autoDispose<Perfil?>((ref) async {
  final repo = ref.watch(repoPerfilProvider);
  return repo.getActivo();
});

final listaPerfilesProvider = StreamProvider<List<Perfil>>((ref) {
  final repositorio = ref.watch(repoPerfilProvider);
  return repositorio.mirarPerfiles();
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final repo = ref.watch(repoTutorProvider); 
  return AuthController(repo);
});