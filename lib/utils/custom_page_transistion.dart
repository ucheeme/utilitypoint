import 'package:flutter/cupertino.dart';

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;
  SlideUpRoute({required this.page}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0,-1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class ScaleUpRoute extends PageRouteBuilder{
  final Widget page;
  ScaleUpRoute({required this.page}): super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>ScaleTransition(scale: Tween<double>(
        begin: 0.0,
        end: 1.5,
      ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
        child: child,
  ));
}