import 'package:design_patterns/patterns/momento/momento.dart';

/// [CartCaretaker] class is responsible for keeping the history of the [CartMemento] objects.
final class CartCaretaker {
  List<CartMemento> _history = [];
  int _currentIndex = -1;

  void saveState(CartMemento memento) {
    CartMemento mementoCopy = memento.copy();

    if (_currentIndex != _history.length - 1) {
      _history = _history.sublist(0, _currentIndex + 1);
    }
    _history.add(mementoCopy);
    _currentIndex = _history.length - 1;
  }

  CartMemento? undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _history[_currentIndex];
    }
    return null;
  }
}
