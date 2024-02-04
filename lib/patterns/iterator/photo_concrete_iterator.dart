import 'package:design_patterns/patterns/iterator/model/photo.dart';

/// [PhotoIterator] is Concrete Iterator
final class PhotoIterator implements Iterator<Photo> {
  final List<Photo> _photos;
  int _current = 0;

  PhotoIterator(this._photos);

  @override
  Photo get current => _photos[_current];

  @override
  bool moveNext() {
    if (_current < _photos.length - 1) {
      _current++;
      return true;
    }
    return false;
  }
}
