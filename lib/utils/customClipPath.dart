import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_constant.dart';

class CustomShapeClipper  extends CustomPainter  {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.primary20
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((0.4 - 0.1) * size.width, 0)
      ..cubicTo(
        (0.4 + 5 * 0.20) * size.width,
        size.height * 0.05,
        0.4 * size.width,
        size.height * 0.60,
        (0.4 + 5 * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (0.4 + 5) * size.width,
        size.height * 0.60,
        (0.4 + 5 - 5 * 0.20) * size.width,
        size.height * 0.05,
        (0.4 + 5 + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
  }




class BNBCustomPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start from the left side
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0); // First curve on the left
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20); // Smooth to top left before the notch

    // Create the arc for the notch in the center
    path.arcToPoint(
      Offset(size.width * 0.60, 20), // End of the notch
      radius:  Radius.circular(20.0),
      clockwise: false,
    );

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0); // Smooth from the notch to the right
    path.quadraticBezierTo(size.width * 0.70, 0, size.width, 0); // Curve down to the top-right
    path.lineTo(size.width, size.height); // Right bottom corner
    path.lineTo(0, size.height); // Left bottom corner
    path.close(); // Complete the path

    canvas.drawShadow(path, Colors.black, 5, true); // Add shadow
    canvas.drawPath(path, paint); // Fill the shape
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.5, size.height, 0, size.height * 0.7);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class NavCustomClipper extends CustomClipper<Rect> {
  final double deviceHeight;

  NavCustomClipper({required this.deviceHeight});

  @override
  Rect getClip(Size size) {
    //Clip only the bottom of the widget
    return Rect.fromLTWH(
      0,
      -deviceHeight + size.height,
      size.width,
      deviceHeight,
    );
  }

  @override
  bool shouldReclip(NavCustomClipper oldClipper) {
    return oldClipper.deviceHeight != deviceHeight;
  }
}