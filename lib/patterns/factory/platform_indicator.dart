import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

abstract class PlatformIndicator {
  Color color();
  Widget build();

  factory PlatformIndicator() {
    if (Platform.isAndroid) {
      return AndroidIndicator();
    } else if (Platform.isIOS) {
      return IOSIndicator();
    } else {
      throw AndroidIndicator();
    }
  }
}

final class AndroidIndicator implements PlatformIndicator {
  @override
  Widget build() => CircularProgressIndicator(
        color: color(),
      );
  @override
  Color color() => Colors.green;
}

final class IOSIndicator implements PlatformIndicator {
  @override
  Widget build() => CupertinoActivityIndicator(
        color: color(),
      );
  @override
  Color color() => Colors.green.shade900;
}
