import '../my_services.dart';

class ServiceLoader {
  static const ServiceLoader _s = ServiceLoader._();
  factory ServiceLoader() => _s;
  const ServiceLoader._();
  //

  static final ChangeNotifierProvider<_LoadersNotifier> _loadings = ChangeNotifierProvider<_LoadersNotifier>((ref) => _LoadersNotifier());

  static bool isLoading(
    dynamic ref,
    dynamic name,
  ) =>
      (ref ?? MyServices.ref)?.watch(_loadings).isLoading(name) ?? false;

  static void setLoading(dynamic name, bool status) => MyServices.ref.read(_loadings.notifier).setLoading(name, status);
}

class _LoadersNotifier extends ChangeNotifier {
  Map<dynamic, bool> state = {};

  bool isLoading(dynamic name) {
    return state[name] == true;
  }

  void setLoading(dynamic name, bool status) {
    state[name] = status;
    notifyListeners();
  }
}
