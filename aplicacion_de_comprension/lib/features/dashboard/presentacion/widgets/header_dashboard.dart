// lib/features/dashboard/presentacion/widgets/dashboard_header.dart
import 'package:flutter/material.dart';
import '../../dominio/entidades/dashboard.dart';

class DashboardHeader extends StatelessWidget {
  final MenuData data;
  final VoidCallback onCerrarSesion;
  final VoidCallback onVerEstadisticas; // <--- NUEVO

  const DashboardHeader({
    super.key,
    required this.data,
    required this.onCerrarSesion,
    required this.onVerEstadisticas, // <--- NUEVO
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent, 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SECCION IZQUIERDA (Avatar y Saludo)
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: AssetImage('assets/imagenes/${data.usuarioAvatar}.png'),
                    errorBuilder: (ctx, _, __) => const Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola, ${data.usuario}!",
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                    ),
                  ),
                  Text(
                    "Nivel: ${(data.progresoTotal * 100).toInt()}% completado",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          
          // SECCION DERECHA (Acciones: Estadísticas y Logout)
          Row(
            mainAxisSize: MainAxisSize.min, // Ocupar solo el espacio necesario
            children: [
              // 1. Botón de Estadísticas (Copa/Trofeo)
              IconButton(
                onPressed: onVerEstadisticas,
                tooltip: "Mis Logros",
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.emoji_events, color: Colors.orange, size: 24),
                ),
              ),
              
              const SizedBox(width: 5), // Espacio entre botones

              // 2. Botón de Cerrar Sesión
              IconButton(
                onPressed: onCerrarSesion, 
                tooltip: "Cerrar Sesión",
                icon: Icon(Icons.logout, color: Colors.deepPurple.shade300)
              )
            ],
          )
        ],
      ),
    );
  }
}