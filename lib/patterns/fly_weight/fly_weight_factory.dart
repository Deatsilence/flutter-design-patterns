import 'package:design_patterns/patterns/fly_weight/icon_fly_weight.dart';
import 'package:flutter/material.dart';

/// [IconFactory] Flyweight Factory
final class IconFactory {
  final Map<IconData, IconFlyweight> _icons = {};

  IconFlyweight getIcon({required IconData iconData}) {
    if (!_icons.containsKey(iconData)) {
      _icons[iconData] = IconFlyweight(iconData);
      debugPrint("Creating new icon: $iconData");
    }
    return _icons[iconData]!;
  }
}
