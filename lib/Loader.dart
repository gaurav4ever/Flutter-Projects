import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoaderState();
  }
}

class LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  final double initRadius = 30;
  double radius = 10;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animationRadiusIn = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
    ));

    animationRadiusOut = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
    ));

    animationController.addListener(() {
      setState(() {
        if (animationController.value >= 0.75 &&
            animationController.value <= 1.0) {
          radius = animationRadiusIn.value * initRadius;
        } else if (animationController.value >= 0.0 &&
            animationController.value <= 0.25) {
          radius = animationRadiusOut.value * initRadius;
        }
      });
    });

    animationController.repeat();

    animationRotation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 1.0, curve: Curves.linear),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150.0,
      height: 150.0,
      child: Center(
        child: RotationTransition(
          turns: animationRotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 30.0,
                color: Colors.grey,
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi), radius * sin(pi)),
                child: Dot(
                  radius: 10.0,
                  color: Colors.red,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * sin(pi), radius * cos(pi)),
                child: Dot(
                  radius: 10.0,
                  color: Colors.red,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * sin(pi / 2), radius * cos(pi / 2)),
                child: Dot(
                  radius: 10.0,
                  color: Colors.red,
                ),
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi / 2), radius * sin(pi / 2)),
                child: Dot(
                  radius: 10.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  final double radius;

  Dot({this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: this.radius,
          height: this.radius,
          decoration: BoxDecoration(color: this.color, shape: BoxShape.circle)),
    );
  }
}
