import 'package:flutter/material.dart';

/// Abstract component class
/// [ProductCard] is the base class for all concrete components, including
abstract class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}

/// Concrete component class
/// [SimpleProductCard] is a simple product card with an image, name, and price.
base class SimpleProductCard extends ProductCard {
  final String imageUrl;
  final String productName;
  final double price;

  const SimpleProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.network(imageUrl, height: 150, width: 150),
          Text(productName),
          Text("$price"),
        ],
      ),
    );
  }
}

/// Decorator abstract class
/// [ProductCardDecorator] is the base class for all concrete decorators,
abstract class ProductCardDecorator extends ProductCard {
  final ProductCard productCard;

  const ProductCardDecorator({required this.productCard, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productCard.build(context);
  }
}

/// Concrete decorator class for on sale products
/// [OnSaleDecorator] adds a red "On Sale!" label to the top left corner of the
final class OnSaleDecorator extends ProductCardDecorator {
  const OnSaleDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          left: 10,
          top: 10,
          child: Text(
            "On Sale!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

/// Concrete decorator class for featured products
/// [OutOfStockProductDecorator] adds a 50% opacity to the product card.
final class OutOfStockProductDecorator extends ProductCardDecorator {
  const OutOfStockProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: super.build(context),
    );
  }
}

/// Concrete decorator class for new products
/// [NewProductDecorator] adds a yellow "New!" label to the top right corner of
final class NewProductDecorator extends ProductCardDecorator {
  const NewProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.new_releases,
            color: Colors.orange,
            size: 30,
          ),
        ),
      ],
    );
  }
}
