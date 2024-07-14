//location
import '../../my_services.dart';

class NoLocationPermissionCard extends StatefulWidget {
  const NoLocationPermissionCard({super.key});

  @override
  _NoLocationPermissionCardState createState() => _NoLocationPermissionCardState();
}

// ignore: prefer_mixin
class _NoLocationPermissionCardState extends State<NoLocationPermissionCard> with WidgetsBindingObserver {
  PermissionStatus? locationPermissionStatus;

  Future<void> init() async {
    locationPermissionStatus = await Location().hasPermission();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      init();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool denied = locationPermissionStatus == PermissionStatus.denied;
    final bool deniedForever = locationPermissionStatus == PermissionStatus.deniedForever;
    final labels = getMyServicesLabels(context);

    Color color = getColorScheme(context).error;
    Color bcColor = getColorScheme(context).onError;

    if (locationPermissionStatus != null && (denied || deniedForever)) {
      return MyInk(
        onTap: getPermission,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        borderRadius: MyServices.services.theme.borderRadius,
        //
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: bcColor,
            borderRadius: MyServices.services.theme.borderRadius,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  labels.accessToYourLocationIsDisabledHoweverYouCanEnableItFromYourDeviceSettings,
                  maxLines: 2,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(color: color, icon: const Icon(iconSettings), onPressed: getPermission)
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Future<void> getPermission() async {
    locationPermissionStatus = await Location.instance.requestPermission();

    final bool denied = locationPermissionStatus == PermissionStatus.denied;
    final bool deniedForever = locationPermissionStatus == PermissionStatus.deniedForever;

    if (denied || deniedForever) {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    } else {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
