/// This code snippet defines two classes, `Product` and `Category`, that implement the `CartItem` abstract class. These classes represent items that can be added to a shopping cart. The `Product` class represents a single product with properties like title, description, image URL, price, and quantity. The `Category` class represents a category of products and can contain multiple child items. Both classes provide methods to get the name and price of the item, as well as a method to build the widget representation of the item.

import 'package:flutter/material.dart';

/// Abstract class representing an item that can be added to a shopping cart.
abstract class CartItem<T extends dynamic> {
  /// Returns the name of the item.
  String getName();

  /// Returns the price of the item.
  double getPrice();

  /// Builds and returns the widget representation of the item.
  T buildItemWidget();
}

/// Represents a single product that can be added to a shopping cart.
final class Product implements CartItem<dynamic> {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  int quantity;

  /// Constructs a new instance of the [Product] class.
  Product({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });

  @override
  String getName() => title;

  @override
  double getPrice() => price * quantity;

  @override
  dynamic buildItemWidget() => Card(
        child: ListTile(
          leading: Image.network("https://picsum.photos/200", width: 60, height: 60),
          title: Text(title),
          subtitle: Text(description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Quantity: $quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {}, // Implement quantity increment
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {}, // Implement quantity decrement
              ),
            ],
          ),
        ),
      );
}

/// Represents a category of products that can be added to a shopping cart.
final class Category implements CartItem<dynamic> {
  final String name;
  final List<CartItem<dynamic>> children;
  bool isExpanded; // Track if category is expanded to show children

  /// Constructs a new instance of the [Category] class.
  Category({
    required this.name,
    required this.children,
    this.isExpanded = false,
  });

  @override
  String getName() => name;

  @override
  double getPrice() => children.fold(0, (sum, child) => sum + child.getPrice());

  @override
  dynamic buildItemWidget() => ExpansionPanel(
        headerBuilder: (context, isExpanded) => Text(name),
        body: Column(
          children: children.map((child) => child.buildItemWidget() as Widget).toList(),
        ),
        isExpanded: isExpanded,
      );
}
