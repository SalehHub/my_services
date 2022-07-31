import 'dart:async';

class ServiceDebounce {
  // static const ServiceDebounce _s = ServiceDebounce._();
  // factory ServiceDebounce() => _s;
  const ServiceDebounce();
  //
  static final Map<String, _ServiceDebounceOperation> _debouncers = {};

  void debounce(VoidDebounceCallback onExecute, [String tag = "debounce-fn", int milliseconds = 300]) {
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

  void cancel(String tag) {
    _debouncers[tag]?.timer.cancel();
    _debouncers.remove(tag);
  }

  void cancelAll() {
    for (final operation in _debouncers.values) {
      operation.timer.cancel();
    }
    _debouncers.clear();
  }

  void fire(String tag) => _debouncers[tag]?.callback();

  int count() => _debouncers.length;
}

typedef VoidDebounceCallback = void Function();

class _ServiceDebounceOperation {
  VoidDebounceCallback callback;
  Timer timer;

  _ServiceDebounceOperation(this.callback, this.timer);
}
