import '../my_services.dart';

class ServiceLoader {
  static const ServiceLoader _s = ServiceLoader._();
  factory ServiceLoader() => _s;
  const ServiceLoader._();
  //
  static final ChangeNotifierProvider<_LoadersNotifier> _loadings = ChangeNotifierProvider<_LoadersNotifier>((ref) => _LoadersNotifier());

  static bool isLoading(dynamic ref, dynamic name) => ref.watch(_loadings).isLoading(name);

  static void setLoading(dynamic ref, dynamic name, bool status, [int expireSecond = 100]) => ref.read(_loadings.notifier).setLoading(name, status, expireSecond);
}

class _LoadersNotifier extends ChangeNotifier {
  Map<dynamic, bool> state = {};

  bool isLoading(dynamic name) {
    return state[name] == true;
  }

  void setLoading(dynamic name, bool status, int expireSecond) {
    state[name] = status;

    if (status) {
      Timer(Duration(seconds: expireSecond), () {
        state[name] = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }
}
