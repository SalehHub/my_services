import '../my_services.dart';

class MyPopupMenu<T> extends StatefulWidget {
  const MyPopupMenu({super.key, this.icon, this.onSelected, required this.items});

  final PopupMenuItemSelected<T>? onSelected;
  final List<MyPopupMenuItem<T>> items;
  final Widget? icon;

  @override
  State<MyPopupMenu<T>> createState() => _MyPopupMenuState<T>();
}

class _MyPopupMenuState<T> extends State<MyPopupMenu<T>> {
  @override
  Widget build(BuildContext context) {
    /// theme from [ServiceTheme] popupMenuTheme
    return PopupMenuButton<T>(
      icon: widget.icon,
      onSelected: widget.onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<T>>[
        ...widget.items.map((e) {
          if (e.show == false) {
            return _PopupMenuItemWidget<T>(show: false, child: const SizedBox());
          } else if (e.isDivider == true) {
            return _PopupMenuItemWidget<T>(height: 5, child: const Divider(height: 1));
          } else if (e.widget != null) {
            return _PopupMenuItemWidget<T>(child: e.widget!);
          } else if (e.isTitle == true) {
            return _PopupMenuItemWidget<T>(enabled: false, child: Text(e.title));
          }
          return _PopupMenuItemWidget<T>(value: e.value, child: _MyPopupMenuItemWidget(widget: e.widget, icon: e.icon, title: e.title, tail: e.tail));
        }).toList()
      ],
    );
  }
}

class MyPopupMenuItem<T> {
  MyPopupMenuItem.tile(this.value, this.icon, this.title, {this.tail, this.show = true})
      : isDivider = false,
        isTitle = false,
        widget = null;

  MyPopupMenuItem.divider([this.show = true])
      : isDivider = true,
        isTitle = false,
        value = null,
        icon = Mdi.division,
        title = "",
        tail = const SizedBox(),
        widget = null;

  MyPopupMenuItem.title(this.title, [this.show = true])
      : isDivider = false,
        isTitle = true,
        value = null,
        icon = Mdi.division,
        tail = const SizedBox(),
        widget = null;

  MyPopupMenuItem.widget(this.widget, [this.show = true])
      : isDivider = false,
        isTitle = false,
        value = null,
        icon = Mdi.division,
        title = "",
        tail = const SizedBox();

  final T? value;
  final IconData icon;
  final String title;
  final Widget? widget;
  final Widget? tail;
  final bool isDivider;
  final bool isTitle;
  final bool show;
}

class _MyPopupMenuItemWidget extends ConsumerWidget {
  const _MyPopupMenuItemWidget({this.widget, this.tail, required this.title, required this.icon});

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

class _PopupMenuItemWidget<T> extends PopupMenuEntry<T> {
  const _PopupMenuItemWidget({
    super.key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.show = true,
    this.height = kMinInteractiveDimension,
    this.padding,
    this.textStyle,
    this.mouseCursor,
    required this.child,
  });

  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  final bool show;
  @override
  final double height;
  final EdgeInsets? padding;

  final TextStyle? textStyle;
  final MouseCursor? mouseCursor;
  final Widget? child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  _PopupMenuItemState<T, _PopupMenuItemWidget<T>> createState() => _PopupMenuItemState<T, _PopupMenuItemWidget<T>>();
}

class _PopupMenuItemState<T, W extends _PopupMenuItemWidget<T>> extends State<W> {
  @protected
  Widget? buildChild() => widget.child;

  @protected
  void handleTap() {
    widget.onTap?.call();

    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) {
      return const SizedBox();
    }

    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style = widget.textStyle ?? popupMenuTheme.textStyle ?? theme.textTheme.subtitle1!;

    if (!widget.enabled) {
      style = style.copyWith(color: theme.disabledColor);
    }

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: widget.height),
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        child: buildChild(),
      ),
    );

    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }
    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!widget.enabled) MaterialState.disabled,
      },
    );

    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: InkWell(
            borderRadius: MyServices.services.theme.borderRadius,
            onTap: widget.enabled ? handleTap : null,
            canRequestFocus: widget.enabled,
            mouseCursor: effectiveMouseCursor,
            child: item,
          ),
        ),
      ),
    );
  }
}
