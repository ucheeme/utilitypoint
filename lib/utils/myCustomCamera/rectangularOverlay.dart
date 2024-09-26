import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectangularOverlayPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RectangularPainter(),
      child: Container(),
    );
  }
}

class CircularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..blendMode = BlendMode.srcOut; // Ensures it creates a hole in the overlay

    final blurPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100));

    canvas.drawPath(blurPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _RectangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..blendMode = BlendMode.srcOut; // Ensures it creates a hole in the overlay

    final blurPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 200, height: 150));

    canvas.drawPath(blurPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}