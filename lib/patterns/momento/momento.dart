import 'package:design_patterns/patterns/momento/model/product.dart';

/// [CartMemento] class is a memento class that holds the state of the [Cart].
final class CartMemento {
  final List<Product> products;

  CartMemento(this.products);

  /// [copy] method is used to create a copy of the [CartMemento] object.
  CartMemento copy() => CartMemento(
        List.from(
          products,
        ),
      );
}
