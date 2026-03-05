import 'package:flutter/material.dart';

class InwardBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    const double curveDepth = 60;

    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - curveDepth,
      size.width * 0.8,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
