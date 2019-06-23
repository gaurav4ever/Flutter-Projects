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
  Animation<double> animationRight;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  final double radius = 30;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150.0,
      height: 150.0,
      child: Center(
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
          ],
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
