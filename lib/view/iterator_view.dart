import 'package:design_patterns/patterns/iterator/photo_collection_aggregate.dart';
import 'package:flutter/material.dart';

/// [IteratorView] is Iterator View.
final class IteratorView extends StatelessWidget {
  final PhotoCollection photos;

  const IteratorView({required this.photos, super.key});

  @override
  Widget build(BuildContext context) {
    var iterator = photos.getIterator();

    return Scaffold(
      appBar: AppBar(title: const Text("Iterator in Flutter")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          if (iterator.moveNext()) {
            return Image.network(iterator.current.url);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
