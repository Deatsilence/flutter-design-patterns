import 'package:design_patterns/patterns/decorator/decorator.dart';
import 'package:flutter/material.dart';

class DecoratorView extends StatefulWidget {
  const DecoratorView({super.key});

  @override
  State<DecoratorView> createState() => _DecoratorViewState();
}

final class _DecoratorViewState extends State<DecoratorView> {
  @override
  Widget build(BuildContext context) {
    // simpleCard is a simple product card with an image, name, and price.
    const ProductCard simpleCard = SimpleProductCard(
      imageUrl: "https://picsum.photos/200",
      productName: "Example Product",
      price: 19.99,
    );

    // complesCard combines multiple decorators to create a complex product card.
    const ProductCard complexCard = OnSaleDecorator(
      productCard: NewProductDecorator(
        productCard: simpleCard,
      ),
    );

    // featureCard is a featured product card with opacity and a shadow.
    const ProductCard featureCard = OutOfStockProductDecorator(
      productCard: simpleCard,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: <Widget>[
          simpleCard.build(context),
          complexCard.build(context),
          featureCard.build(context),
        ],
      ),
    );
  }
}
