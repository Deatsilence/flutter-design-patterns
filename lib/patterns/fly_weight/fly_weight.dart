import 'package:flutter/material.dart';

/// [Flyweight] interface
abstract class Flyweight {
  Widget createWidget(Color color, double size);
}
