import 'package:design_patterns/patterns/observer/model/item.dart';
import 'package:mobx/mobx.dart';

part 'observer.g.dart';

final class ShoppingItemsStore = ShoppingItemsStoreBase with _$ShoppingItemsStore;

abstract class ShoppingItemsStoreBase with Store {
  /// The list of items that the user had added to the cart.
  @observable
  ObservableList<Item> items = ObservableList.of(
    [
      const Item(
        id: '1',
        image: 'https://picsum.photos/200',
        name: 'Food 1',
        price: 10.0,
      ),
      const Item(
        id: '2',
        image: 'https://picsum.photos/200',
        name: 'Food 2',
        price: 20.0,
      ),
    ],
  );

  @observable
  double totalPrice = 30.0;

  /// [increase] Increases the quantity of the item by 1.
  @action
  void increase(Item item, int index) {
    if (!items.contains(item)) {
      items.add(item);
    }

    items[index] = item.copyWith(quantity: item.quantity + 1);
    totalPrice += item.price;
  }

  /// [decrease] Decreases the quantity of the item by 1.
  @action
  void decrease(Item item, int index) {
    if (items.contains(item) && items[index].quantity >= 1 && totalPrice >= item.price) {
      totalPrice -= item.price;

      items[index] = item.copyWith(quantity: item.quantity - 1);
      if (items[index].quantity == 0) {
        items.remove(item);
      }
    }
  }
}
