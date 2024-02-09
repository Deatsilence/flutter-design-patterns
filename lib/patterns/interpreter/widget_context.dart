import 'package:flutter/material.dart';

/// [WidgetContext] is the context class
final class WidgetContext {
  // Renkleri ve diğer ortak bilgileri saklamak için kullanılır
  Map<String, Color> colorMap;

  WidgetContext({required this.colorMap});

  Color getColor(String colorName) {
    return colorMap[colorName] ?? Colors.black;
  }

  // İhtiyaç duyulan diğer ortak bilgiler ve işlevler burada tanımlanabilir
}
