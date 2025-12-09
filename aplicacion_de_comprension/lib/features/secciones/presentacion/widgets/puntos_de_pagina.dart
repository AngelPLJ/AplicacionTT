import 'package:flutter/material.dart';

class PuntosDePagina extends StatelessWidget {
  final int count;
  final int index;
  const PuntosDePagina({
    super.key,
    required this.count, 
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          width: i == index ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == index
                ? Theme.of(context).colorScheme.primary
                : const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}