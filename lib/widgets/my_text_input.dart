import '../my_services.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({
    super.key,
    this.show = true,
    this.value,
    this.validator,
    this.prefixText,
    this.labelText,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.directionalityTextDirection,
    this.textDirection,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.withController = true,
    this.enabled = true,
    this.borderRadius,
    this.maxLines = 1,
    this.length,
    this.digitsOnly = false,
    this.textInputAction = TextInputAction.done,
    this.margin = const EdgeInsets.only(top: 5),
    this.contentPadding,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabel = false,
    this.withPasteButton = false,
    this.strutStyle,
    this.style,
    this.border,
    this.isDropDown = false,
    this.items = const [],
    this.widget,
    this.onTap,
  });

  final bool show;
  final bool isDropDown;
  final String? value;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final String? prefixText;
  final String? labelText;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextDirection? textDirection;
  final TextDirection? directionalityTextDirection;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;
  final int maxLines;
  final int? length;
  final bool digitsOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final bool floatingLabel;
  final bool withPasteButton;
  final bool withController;
  final bool enabled;
  final StrutStyle? strutStyle;
  final InputBorder? border;
  final List<MyDropdownMenuItemData> items;
  final Widget? widget;
  final GestureTapCallback? onTap;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.isDropDown == false && widget.withController == true) {
      controller = widget.controller ?? TextEditingController();
      controller?.text = widget.value ?? "";
    }
  }

  @override
  void dispose() {
    try {
      controller?.dispose();
      widget.controller?.dispose();
    } catch (e) {
      //
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyTextInput oldWidget) {
    if (widget.isDropDown == false && widget.withController == true) {
      if (widget.value != controller!.text) {
        controller?.text = widget.value ?? "";
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // return buildStackField(context);

    if (!widget.show) {
      return const SizedBox();
    }

    if (widget.isDropDown) {
      return Padding(
        padding: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel(context),
            DropdownButtonFormField<String>(
              borderRadius: widget.borderRadius ?? MyServices.services.theme.borderRadius,
              validator: widget.validator,
              value: widget.value,
              onChanged: (String? v) {
                if (v != null) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(v);
                  }
                }
              },
              items: widget.items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.value,
                      child: Row(
                        children: [
                          if (e.icon != null) e.icon!,
                          if (e.icon != null) const SizedBox(width: 5),
                          //to fix the overflow issue when text is to long
                          LayoutBuilder(builder: (context, constraints) {
                            // print(constraints.maxWidth);

                            double width = constraints.maxWidth == double.infinity ? MyServices.helpers.getPageWidth(context) : constraints.maxWidth;
                            // print(width);

                            width = width * 0.6;

                            // print(width);

                            return SizedBox(
                              // color: Colors.amber,
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: MyText(e.text, maxLines: 1, overflow: TextOverflow.fade),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              decoration: buildMyInputDecoration(),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: buildLabel(context)),
              //
              if (widget.withPasteButton)
                IconButton(
                  onPressed: () async {
                    String? data = (await Clipboard.getData('text/plain'))?.text;
                    if (data != null) {
                      // controller?.text = data;
                      if (widget.onChanged != null) {
                        widget.onChanged!(data);
                      }
                    }
                  },
                  icon: const Icon(Mdi.contentPaste),
                ),
              //
            ],
          ),
          if (widget.widget != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500, width: 0.8),
                borderRadius: MyServices.services.theme.borderRadius,
              ),
              child: widget.widget!,
            )
          else if (widget.directionalityTextDirection != null)
            Directionality(
              textDirection: widget.textDirection ?? Directionality.of(context),
              child: buildTextInput(),
            )
          else
            buildTextInput(),
        ],
      ),
    );
  }

  Widget buildTextInput() {
    if (widget.maxLines > 1) {
      return SizedBox(height: widget.maxLines > 1 ? widget.maxLines * 45 : null, child: buildTextFormField());
    }
    return buildTextFormField();
  }

  Widget buildTextFormField() {
    return TextFormField(
      //
      controller: widget.withController ? controller : null,
      initialValue: widget.withController ? null : widget.value,
      //
      onTap: widget.onTap,
      readOnly: widget.onTap != null,
      enabled: widget.enabled,
      //
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      //
      validator: widget.validator,
      textDirection: widget.textDirection,
      obscureText: widget.isPassword,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      inputFormatters: [
        if (widget.length != null) LengthLimitingTextInputFormatter(widget.length),
        if (widget.digitsOnly) FilteringTextInputFormatter.digitsOnly,
      ],
      maxLines: widget.maxLines,
      strutStyle: widget.strutStyle ?? const StrutStyle(height: 2.1),
      style: widget.style,
      textAlignVertical: widget.maxLines == 1 ? TextAlignVertical.center : TextAlignVertical.top,
      decoration: buildMyInputDecoration(),
      onChanged: (String v) {
        if (widget.onChanged != null) {
          widget.onChanged!(v);
          setState(() {});
        }
      },
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  Widget buildLabel(BuildContext context) {
    // print(Directionality.of(context));
    if (widget.floatingLabel) {
      return const SizedBox();
    }
    return MyText(
      widget.labelText,
      bold: true,
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }

  InputDecoration buildMyInputDecoration() {
    return InputDecoration(
      prefixText: widget.prefixText,
      alignLabelWithHint: true,
      labelStyle: widget.labelStyle,
      floatingLabelStyle: widget.floatingLabelStyle,
      labelText: widget.floatingLabel ? widget.labelText : null,
      helperText: widget.helperText,
      contentPadding: buildContentPadding(),
      suffixIcon: widget.suffixIcon,
      prefixIcon: buildPrefixIcon(),
      isDense: true,
      // isCollapsed: true,
      border: widget.border ?? OutlineInputBorder(borderRadius: widget.borderRadius ?? MyServices.services.theme.borderRadius),
    );
  }

  EdgeInsetsGeometry? buildContentPadding() {
    if (widget.contentPadding != null) {
      return widget.contentPadding;
    } else if (widget.isDropDown) {
      return const EdgeInsets.fromLTRB(10, 15, 10, 15);
    } else {
      return EdgeInsets.fromLTRB(
        widget.suffixIcon == null ? 10 : 10,
        10,
        widget.suffixIcon == null ? 10 : 10,
        10,
      );
    }

    // contentPadding ?? (isDropDown ? const EdgeInsets.fromLTRB(10, 15, 10, 15) : EdgeInsets.fromLTRB(suffixIcon == null ? 15 : 0, 10, 10, 10))
  }

  Widget? buildPrefixIcon() {
    if (widget.prefixIcon == null) {
      return null;
    } else if (widget.maxLines == 1) {
      return widget.prefixIcon;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Align(
        alignment: Alignment.topCenter,
        widthFactor: 1.0,
        heightFactor: 10.0,
        child: widget.prefixIcon,
      ),
    );
  }
}

class MyDropdownMenuItemData {
  final String text;
  final String value;
  final Widget? icon;

  const MyDropdownMenuItemData(this.text, this.value, {this.icon});
}
