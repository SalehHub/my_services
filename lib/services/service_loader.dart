import '../my_services.dart';

class ServiceLoader {
  static final _loadings = ChangeNotifierProvider<_LoadersNotifier>((ref) => _LoadersNotifier());

  static bool isLoading(dynamic ref, dynamic name) => ref.watch(_loadings).isLoading(name);

  static void setLoading(dynamic ref, dynamic name, bool status) => ref.read(_loadings.notifier).setLoading(name, status);
}

class _LoadersNotifier extends ChangeNotifier {
  Map<dynamic, bool> state = {};

  bool isLoading(dynamic name) => state[name] == true;

  void setLoading(dynamic name, bool status) {
    state[name] = status;
    notifyListeners();
  }
}
