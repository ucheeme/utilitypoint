import 'package:flutter/cupertino.dart';
import 'package:utilitypoint/utils/myCustomCamera/rectangularOverlay.dart';

class CircularOverlayPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularPainter(),
      child: Container(),
    );
  }
}