import 'package:flutter/material.dart';

@immutable
final class SocialMediaPost {
  final String title;
  final String content;

  const SocialMediaPost({
    required this.title,
    required this.content,
  });
}
