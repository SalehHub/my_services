import '../my_services.dart';

class MySideMenu extends StatelessWidget {
  const MySideMenu({
    Key? key,
    this.name,
    this.email,
    this.imageUrl,
    this.avatarIcon = Icons.account_circle,
    this.imageBlurhash,
    this.bgImageUrl,
    this.bgImageBlurhash,
    this.children = const [],
    this.onAvatarTap,
  }) : super(key: key);

  final String? name;
  final String? email;
  final String? imageUrl;
  final IconData avatarIcon;
  final String? imageBlurhash;
  final String? bgImageUrl;
  final String? bgImageBlurhash;
  final List<MySideMenuTile> children;
  final GestureTapCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25, left: 10, right: 10),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: imageUrl ?? "d",
              child: MyContainer(
                height: 160,
                bgImageOpacity: 0.1,
                bgImageUrl: bgImageUrl,
                bgColor: ServiceTheme.theme(context).primary.withOpacity(0.02),
                bgImageBlurHash: bgImageBlurhash,
                borderRadius: ServiceTheme.borderRadius.copyWith(bottomLeft: Radius.zero, bottomRight: Radius.zero),
                onTap: onAvatarTap,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Spacer(),
                      if (imageUrl == null)
                        CircleAvatar(
                          child: Icon(avatarIcon, size: 40),
                          radius: 30,
                          backgroundColor: ServiceTheme.theme(context).primary,
                          foregroundColor: ServiceTheme.theme(context).onPrimary,
                        )
                      else
                        MyLoadingImage(
                          url: imageUrl!,
                          circle: true,
                          borderColor: ServiceTheme.theme(context).primary,
                          borderWidth: 2,
                          width: 70,
                          height: 70,
                        ),
                      SizedBox(height: 10),
                      Text(name ?? "", style: getTextTheme(context).subtitle1),
                      Text(email ?? "", style: getTextTheme(context).caption),
                    ],
                  ),
                ),
              ),
            ),

            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     borderRadius: ServiceTheme.borderRadius.copyWith(bottomLeft: Radius.zero, bottomRight: Radius.zero),
            //     image: (imageUrl == null)
            //         ? null
            //         : DecorationImage(
            //             colorFilter: isDark(context) ? const ColorFilter.mode(Colors.black87, BlendMode.srcATop) : const ColorFilter.mode(Colors.white70, BlendMode.srcATop),
            //             fit: BoxFit.cover,
            //             image: CachedNetworkImageProvider(imageUrl!),
            //           ),
            //   ),
            //   margin: EdgeInsets.zero,
            //   currentAccountPictureSize: const Size(60, 60),
            //   currentAccountPicture: GestureDetector(
            //     onTap: onAvatarTap,
            //     child: imageUrl == null ? CircleAvatar(child: Icon(avatarIcon, size: 35)) : MyLoadingImage(url: imageUrl!, blurHash: imageBlurhash, circle: true),
            //   ),
            //   accountName: GestureDetector(
            //     onTap: onAvatarTap,
            //     child: MyText(
            //       name,
            //       textAlign: TextAlign.center,
            //       style: getTextTheme(context).subtitle2?.copyWith(fontWeight: FontWeight.bold),
            //     ),
            //   ),
            //   accountEmail: GestureDetector(
            //     onTap: onAvatarTap,
            //     child: Text(email ?? '', textDirection: TextDirection.ltr),
            //   ),
            // ),

            const SizedBox(height: 5),
            ...children,
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class MySideMenuTile extends StatelessWidget {
  const MySideMenuTile({
    Key? key,
    this.title,
    this.icon,
    this.onTap,
    this.isDivider = false,
    this.show = true,
    this.child,
    this.children,
    this.trailing,
  }) : super(key: key);

  const MySideMenuTile.divider({Key? key})
      : icon = null,
        title = null,
        onTap = null,
        isDivider = true,
        show = true,
        child = null,
        trailing = null,
        children = null,
        super(key: key);

  const MySideMenuTile.widget({Key? key, required this.child})
      : icon = null,
        title = null,
        onTap = null,
        isDivider = false,
        show = true,
        trailing = null,
        children = null,
        super(key: key);

  final String? title;
  final IconData? icon;
  final GestureTapCallback? onTap;
  final bool isDivider;
  final bool show;
  final Widget? child;
  final List<MySideMenuTile>? children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (show == false) {
      return const SizedBox();
    }

    if (isDivider) {
      return const Divider();
    }

    if (child != null) {
      return child!;
    }

    if (children != null && children?.isEmpty == false) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        elevation: 0,
        shape: Theme.of(context).listTileTheme.shape,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: Icon(icon),
            title: MyText(title),
            trailing: trailing,
            children: children!,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: ListTile(
        shape: Theme.of(context).listTileTheme.shape,
        leading: Icon(icon),
        title: MyText(title),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
