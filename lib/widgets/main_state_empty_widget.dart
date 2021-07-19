import '../my_services.dart';

class PageEmptyWidget extends StatelessWidget {
  const PageEmptyWidget({
    Key? key,
    required this.noDataIcon,
    required this.noDataLabel,
    this.margin = const EdgeInsets.all(5),
  }) : super(key: key);
  final EdgeInsets margin;

  final IconData noDataIcon;
  final String noDataLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 60),
          Icon(noDataIcon, size: 80),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              noDataLabel,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
