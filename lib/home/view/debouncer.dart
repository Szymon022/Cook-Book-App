import 'dart:async';

class Debouncer {
  Debouncer({required int milliseconds}) : _milliseconds = milliseconds;

  final int _milliseconds;
  Timer? _timer;

  void run(void Function() action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: _milliseconds), action);
  }
}
