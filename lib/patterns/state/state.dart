import 'package:flutter/material.dart';

/// [CartWidget] is a widget that is a colleague in the mediator pattern.
final class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int itemCount = 0;

  void addItem() {
    setState(() {
      itemCount++;
    });
  }

  void removeItem() {
    setState(() {
      itemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Amount of product in basket: $itemCount'),
              OutlinedButton(
                onPressed: addItem,
                child: const Text('Add Product to Basket'),
              ),
              OutlinedButton(
                onPressed: removeItem,
                child: const Text('Remove Product from Basket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
