import 'package:flutter/material.dart';

@immutable
final class Item {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  const Item({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Item copyWith({
    String? id,
    String? image,
    String? name,
    double? price,
    int? quantity,
  }) {
    return Item(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
