import 'package:design_patterns/patterns/fly_weight/fly_weight.dart';
import 'package:flutter/material.dart';

/// [IconFlyweight] Concrete Flyweight
final class IconFlyweight implements Flyweight {
  final IconData iconData;

  IconFlyweight(this.iconData);

  @override
  Widget createWidget(Color color, double size) {
    return Icon(iconData, color: color, size: size);
  }
}
