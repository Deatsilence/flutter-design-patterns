import 'package:design_patterns/patterns/observer/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final class ObserverView extends StatefulWidget {
  const ObserverView({super.key});

  @override
  State<ObserverView> createState() => _ObserverViewState();
}

class _ObserverViewState extends State<ObserverView> {
  late final ShoppingItemsStore _store;

  @override
  void initState() {
    super.initState();
    _store = ShoppingItemsStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observer'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: double.infinity,
          child: Observer(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _store.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _Food(store: _store, index: index);
                  },
                ),
                const SizedBox(height: 20),
                Text('Total Price: ${_store.totalPrice}'),
              ],
            );
          }),
        ),
      ),
    );
  }
}

final class _Food extends StatelessWidget {
  const _Food({
    super.key,
    required ShoppingItemsStore store,
    required this.index,
  }) : _store = store;

  final ShoppingItemsStore _store;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_store.items[index].name),
      subtitle: Text("Price: ${_store.items[index].price}"),
      leading: Image.network(_store.items[index].image),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              _store.decrease(_store.items[index], index);
            },
          ),
          Text('${_store.items[index].quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _store.increase(_store.items[index], index);
            },
          ),
        ],
      ),
    );
  }
}
