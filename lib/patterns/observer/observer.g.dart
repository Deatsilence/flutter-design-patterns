// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observer.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingItemsStore on ShoppingItemsStoreBase, Store {
  late final _$itemsAtom =
      Atom(name: 'ShoppingItemsStoreBase.items', context: context);

  @override
  ObservableList<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$totalPriceAtom =
      Atom(name: 'ShoppingItemsStoreBase.totalPrice', context: context);

  @override
  double get totalPrice {
    _$totalPriceAtom.reportRead();
    return super.totalPrice;
  }

  @override
  set totalPrice(double value) {
    _$totalPriceAtom.reportWrite(value, super.totalPrice, () {
      super.totalPrice = value;
    });
  }

  late final _$ShoppingItemsStoreBaseActionController =
      ActionController(name: 'ShoppingItemsStoreBase', context: context);

  @override
  void increase(Item item, int index) {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.increase');
    try {
      return super.increase(item, index);
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrease(Item item, int index) {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.decrease');
    try {
      return super.decrease(item, index);
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
totalPrice: ${totalPrice}
    ''';
  }
}
