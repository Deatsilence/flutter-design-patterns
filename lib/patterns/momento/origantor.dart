import 'dart:math';

import 'package:design_patterns/patterns/momento/caretaker.dart';
import 'package:design_patterns/patterns/momento/model/product.dart';
import 'package:design_patterns/patterns/momento/momento.dart';
import 'package:flutter/material.dart';

/// [ShoppingCartWidget] Originator
final class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({super.key});

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  List<Product> products = [];
  CartCaretaker caretaker = CartCaretaker();

  @override
  void initState() {
    super.initState();
    saveState();
  }

  void addProduct(Product product) {
    setState(() {
      products.add(product);
      saveState();
    });
  }

  void removeProduct(Product product) {
    setState(() {
      products.remove(product);
      saveState();
    });
  }

  void saveState() {
    caretaker.saveState(CartMemento(products));
  }

  void undo() {
    var memento = caretaker.undo();
    if (memento != null) {
      setState(() {
        products = memento.products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Products List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name),
                    subtitle: Text(products[index].price.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => removeProduct(products[index]),
                    ),
                  );
                },
              ),
            ),

            /// Undo and redo buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Add Product button
                ElevatedButton(
                  onPressed: () => addProduct(Product(
                      name: 'New Product ${products.length + 1}',
                      price: double.parse(
                          (Random().nextDouble() * 100).toStringAsFixed(2)))),
                  child: const Text('Add Product'),
                ),
                const SizedBox(width: 8),

                /// Undo button
                ElevatedButton(
                  onPressed: undo,
                  child: const Text('Undo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
