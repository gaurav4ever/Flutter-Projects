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

  final double initRadius = 15;
  double radius = 5;

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
                radius: initRadius,
                color: Colors.grey,
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.orange,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.yellow,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.green,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blue,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blueAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.purple,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    radius * cos((7 * pi) / 4), radius * sin((7 * pi) / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.red,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    radius * cos((8 * pi) / 4), radius * sin((8 * pi) / 4)),
                child: Dot(
                  radius: 5.0,
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
