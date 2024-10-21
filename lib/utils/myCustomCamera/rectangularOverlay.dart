import 'dart:io';

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

class RectangularOverlayPainterNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RectangularOverlayPainter(),
      child: Container(),
    );
  }
}

class _RectangularOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent // Set overlay color and transparency
      ..style = PaintingStyle.fill;

    final overlayRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.8, // Adjust as necessary
        height: size.height * 0.4, // Adjust as necessary
      ),
      Radius.circular(20),
    );

    canvas.drawRRect(overlayRect, paint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRRect(overlayRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captured Image')),
      body: Center(
        child: Image.file(File(imagePath)), // Display the cropped image
      ),
    );
  }
}