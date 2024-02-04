import 'package:flutter/material.dart';

/// [Photo] is a simple model class that holds the url of a photo.
@immutable
final class Photo {
  final String url;
  const Photo(this.url);
}
