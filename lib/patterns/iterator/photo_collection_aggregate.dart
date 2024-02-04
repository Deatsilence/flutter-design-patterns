import 'package:design_patterns/patterns/iterator/model/photo.dart';

/// [PhotoCollection] is the Concrete Aggregate.
final class PhotoCollection {
  final List<Photo> _photos = [];

  void addPhoto(Photo photo) {
    _photos.add(photo);
  }

  /// [getIterator] returns an iterator for the collection.
  Iterator<Photo> getIterator() => _photos.iterator;

  int get length => _photos.length;
}
