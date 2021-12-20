import 'dart:async';

class ServiceDebounce {
  static final Map<String, _ServiceDebounceOperation> _debouncers = {};

  static void debounce(VoidDebounceCallback onExecute, [String tag = "debounce-fn", int milliseconds = 300]) {
    if (milliseconds == 0) {
      _debouncers[tag]?.timer.cancel();
      _debouncers.remove(tag);
      onExecute();
    } else {
      _debouncers[tag]?.timer.cancel();
      _debouncers[tag] = _ServiceDebounceOperation(
        onExecute,
        Timer(Duration(milliseconds: milliseconds), () {
          _debouncers[tag]?.timer.cancel();
          _debouncers.remove(tag);
          onExecute();
        }),
      );
    }
  }

  static void cancel(String tag) {
    _debouncers[tag]?.timer.cancel();
    _debouncers.remove(tag);
  }

  static void cancelAll() {
    for (final operation in _debouncers.values) {
      operation.timer.cancel();
    }
    _debouncers.clear();
  }

  static void fire(String tag) => _debouncers[tag]?.callback();

  static int count() => _debouncers.length;
}

typedef VoidDebounceCallback = void Function();

class _ServiceDebounceOperation {
  VoidDebounceCallback callback;
  Timer timer;

  _ServiceDebounceOperation(this.callback, this.timer);
}
