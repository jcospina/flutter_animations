import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) =>
      GrowTransition(child: LogoWidget(), animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LogoWidget extends StatelessWidget {
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Container(
              height: animation.value, width: animation.value, child: child),
          child: child,
        ),
      );
}
