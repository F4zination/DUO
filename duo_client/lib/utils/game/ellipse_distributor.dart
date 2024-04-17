import 'dart:math';
import 'package:flutter/material.dart';

class EllipseWidgetDistributor extends StatelessWidget {
  final List<Widget> children;
  final double radiusX;
  final double radiusY;

  // Constructor with the radiusX and radiusY parameters
  const EllipseWidgetDistributor({
    super.key,
    required this.children,
    this.radiusX = 200,
    this.radiusY = 100,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the angle between widgets. This remains the same as we're still distributing along a ellipse.
    final double angleInterval = pi / (children.length - 1);

    List<Widget> positionedChildren = [];
    for (int i = 0; i < children.length; i++) {
      final double angle = angleInterval * i;
      // Use the ellipse formula with radiusX and radiusY for x and y calculations
      final double x = radiusX * cos(angle);
      final double y = radiusY * sin(angle);
      positionedChildren.add(
        Positioned(
          left: radiusX +
              x, // Centering adjustment based on ellipse's horizontal radius
          top: radiusY -
              y, // Adjust vertical position, considering the top of the widget as the ellipse's vertical radius
          child: children[i],
        ),
      );
    }

    return Stack(
      children: positionedChildren,
    );
  }
}
