import 'package:flutter/material.dart';

/// [Product] class is a model class that holds the product details.
@immutable
final class Product {
  final String name;
  final double price;

  const Product({
    required this.name,
    required this.price,
  });
}
