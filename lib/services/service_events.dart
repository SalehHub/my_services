//appLinks
import '../my_services.dart';

class ServiceEvents {
  // static const ServiceEvents _s = ServiceEvents._();
  // factory ServiceEvents() => _s;
  // const ServiceEvents._();
  const ServiceEvents();

  static final Map<String, List> _listeners = {};

  void listen<T>(Function(T) listener) {
    final String event = T.toString();

    if (_listeners[event] == null) {
      _listeners[event] = [listener];
    } else {
      _listeners[event]!.add(listener);
    }
  }

  void fire<T>(T event) {
    List? listeners = _listeners[T.toString()];

    if (listeners == null || listeners.isEmpty) {
      return;
    }

    for (final Function(T) listener in listeners) {
      listener(event);
    }
  }
}
