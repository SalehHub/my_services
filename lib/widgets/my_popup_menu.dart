import '../my_services.dart';

class MyPopupMenu<T> extends StatefulWidget {
  const MyPopupMenu({Key? key, this.onSelected, required this.items}) : super(key: key);

  final PopupMenuItemSelected<T>? onSelected;
  final List<MyPopupMenuItem<T>> items;

  @override
  State<MyPopupMenu<T>> createState() => _MyPopupMenuState<T>();
}

class _MyPopupMenuState<T> extends State<MyPopupMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      onSelected: widget.onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<T>>[
        ...widget.items.map((e) {
          if (e.isDivider == true) {
            return PopupMenuItem<T>(height: 5, child: const Divider(height: 1));
          }
          return PopupMenuItem<T>(value: e.value, child: _MyPopupMenuItemWidget(widget: e.widget, icon: e.icon, title: e.title, tail: e.tail));
        }).toList()
      ],
    );
  }
}

class MyPopupMenuItem<T> {
  MyPopupMenuItem(this.value, this.icon, this.title, [this.widget, this.tail, this.isDivider = false]);

  MyPopupMenuItem.divider()
      : isDivider = true,
        value = null,
        icon = Mdi.division,
        title = "",
        tail = const SizedBox(),
        widget = const SizedBox();

  final T? value;
  final IconData icon;
  final String title;
  final Widget? widget;
  final Widget? tail;
  final bool isDivider;
}

class _MyPopupMenuItemWidget extends ConsumerWidget {
  const _MyPopupMenuItemWidget({Key? key, this.widget, this.tail, required this.title, required this.icon}) : super(key: key);

  final Widget? widget;
  final Widget? tail;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget ?? Padding(padding: const EdgeInsets.all(0.0), child: Icon(icon)),
        const SizedBox(width: 4),
        Text(title, style: getTextTheme(context).bodyText1?.copyWith(height: 2)),
        const Spacer(),
        if (tail != null) tail!,
      ],
    );
  }
}
