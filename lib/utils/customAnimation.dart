import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

// Custom reusable class for animation and text controller management
class SlideAnimationManager {
  late AnimationController _slideController;
  late AnimationController _slideControllerTop;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;
  late TextEditingController pinValueController;
  late TextEditingController ttController;
  StreamController<ErrorAnimationType>? errorController;

  SlideAnimationManager(TickerProvider vsync) {
    // Initialize text controllers
    pinValueController = TextEditingController();
    ttController = TextEditingController();

    // Initialize error controller
    errorController = StreamController<ErrorAnimationType>();

    // Initialize animation controllers
    _slideController = AnimationController(
      vsync: vsync,
     // duration: Duration(milliseconds: 600),
      duration: Duration(milliseconds: 1),
    );

    _slideControllerTop = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 1),
     // duration: Duration(milliseconds: 600),
    );

    // Slide animation for top
    _slideAnimationTop = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideControllerTop,
      curve: Curves.easeInOut,
    ));

    // Slide animation from bottom
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _slideController.forward();
    _slideControllerTop.forward();
  }

  Animation<Offset> get slideAnimation => _slideAnimation;
  Animation<Offset> get slideAnimationTop => _slideAnimationTop;

  TextEditingController getPinValueController() => pinValueController;
  TextEditingController getTtController() => ttController;

  // Dispose all controllers
  void dispose() {
    _slideController.dispose();
    _slideControllerTop.dispose();
    pinValueController.dispose();
    ttController.dispose();
    errorController?.close();
  }
}