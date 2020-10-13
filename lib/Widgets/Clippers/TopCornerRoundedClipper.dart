import 'dart:math';

import 'package:flutter/material.dart';

class TopCornerRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30;
    double highestY = size.height * 0.3;
    var startPoint = Offset(0, size.height * 0.25);
    var controlPoint = Offset(size.width / 30, size.height * 0.275);
    var endPoint = Offset(size.width / 10, highestY);

    Path path = new Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.arcToPoint(new Offset(size.width - radius, 0), radius: Radius.circular(radius));
    path.lineTo(radius, 0);
    path.arcToPoint(new Offset(0, radius), radius: Radius.circular(radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
