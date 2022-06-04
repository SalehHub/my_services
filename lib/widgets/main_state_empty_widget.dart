import '../my_services.dart';

class PageEmptyWidget extends StatelessWidget {
  const PageEmptyWidget({
    super.key,
    required this.icon,
    required this.label,
    this.margin = const EdgeInsets.all(5),
  });
  final EdgeInsets margin;

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 60),
          Icon(icon, size: 80),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              label,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
