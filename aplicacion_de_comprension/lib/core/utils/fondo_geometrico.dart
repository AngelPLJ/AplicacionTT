import 'dart:math';
import 'package:flutter/material.dart';

class FondoGeometricoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double altoDelPatron = 300.0;
    final int repeticiones = (size.height / altoDelPatron).ceil();

    for (int i = 0; i < repeticiones; i++) {
      canvas.save();
      canvas.translate(0, i * altoDelPatron);
      _dibujarPatron(canvas, Size(size.width, altoDelPatron), i);
      canvas.restore();
    }
  }

  void _dibujarPatron(Canvas canvas, Size size, int seed) {
    final random = Random(seed);

    // --- AJUSTE DE COLORES AQUÍ ---
    // Subí la opacidad de 0.06 a 0.12 y 0.15 para que se noten más.
    final colorPrimario = Colors.deepPurple.withOpacity(0.12); 
    final colorSecundario = Colors.purpleAccent.withOpacity(0.12);
    final colorAcento = Colors.orange.withOpacity(0.15); // Naranja un poco más fuerte

    final paintFill = Paint()..style = PaintingStyle.fill;
    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // 1. Círculo grande (Donut)
    paintStroke.color = colorPrimario;
    paintStroke.strokeWidth = 8;
    canvas.drawCircle(
      Offset(size.width * random.nextDouble(), size.height * random.nextDouble()), 
      40 + random.nextDouble() * 40,
      paintStroke
    );

    // 2. Cápsula diagonal
    final paintCapsula = Paint()
      ..color = colorSecundario
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20 + random.nextDouble() * 15
      ..strokeCap = StrokeCap.round;
    
    final p1 = Offset(size.width * random.nextDouble(), size.height * random.nextDouble());
    final p2 = Offset(p1.dx + (random.nextBool() ? 100 : -100), p1.dy + (random.nextBool() ? 80 : -80));
    canvas.drawLine(p1, p2, paintCapsula);

    // 3. Círculo sólido
    paintFill.color = colorAcento;
    canvas.drawCircle(
      Offset(size.width * random.nextDouble(), size.height * random.nextDouble()), 
      15 + random.nextDouble() * 20, 
      paintFill
    );

    // 4. ZigZag
    final pathZigZag = Path();
    var startX = size.width * random.nextDouble();
    var startY = size.height * random.nextDouble();
    pathZigZag.moveTo(startX, startY);
    for (int i = 0; i < 5; i++) {
      startX += 10;
      startY += (i.isEven ? -15 : 15) * (0.8 + random.nextDouble()); 
      pathZigZag.lineTo(startX, startY);
    }
    // Subí este color a 0.2 para que las líneas finas se definan mejor
    paintStroke.color = Colors.deepPurple.withOpacity(0.2); 
    paintStroke.strokeWidth = 4;
    canvas.drawPath(pathZigZag, paintStroke);

    // 5. Grid de puntos
    // También subí este un poco
    paintFill.color = Colors.purple.withOpacity(0.18); 
    int cantidadPuntos = 3 + random.nextInt(5); 
    for (int i = 0; i < cantidadPuntos; i++) {
      canvas.drawCircle(
        Offset(size.width * random.nextDouble(), size.height * random.nextDouble()), 
        2.0 + random.nextDouble() * 3.0, 
        paintFill
      );
    }

    // 6. Arco Decorativo
    if (random.nextBool()) {
        final rect = Rect.fromCircle(
            center: Offset(size.width * random.nextDouble(), size.height * random.nextDouble()), 
            radius: 60 + random.nextDouble() * 50
        );
        paintStroke.color = colorSecundario;
        paintStroke.strokeWidth = 6;
        canvas.drawArc(rect, random.nextDouble() * 3.14, 1.5 + random.nextDouble(), false, paintStroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}