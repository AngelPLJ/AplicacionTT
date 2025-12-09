import 'package:flutter/material.dart';
import '../../repositorios/modelo_introduccion.dart';
class PaginaIntroduccion extends StatelessWidget {
  final IntroduccionDatos datos;
  const PaginaIntroduccion({
    super.key,
    required this.datos
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(datos.title,
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(datos.text,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}