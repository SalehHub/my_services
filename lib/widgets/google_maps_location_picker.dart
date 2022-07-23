//googleMaps
import '../my_services.dart';

class GoogleMapsLocationPicker extends StatefulWidget {
  const GoogleMapsLocationPicker({super.key, this.lat, this.lng, required this.onLocationPicked, this.title});

  final String? title;
  final double? lat;
  final double? lng;
  final Function(dynamic lat, dynamic lng) onLocationPicked;

  @override
  _GoogleMapsLocationPickerState createState() => _GoogleMapsLocationPickerState();
}

class _GoogleMapsLocationPickerState extends State<GoogleMapsLocationPicker> {
  double? newLat;
  double? newLng;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: MyServices.services.theme.borderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: const Icon(iconCloseCircle), color: Colors.red, onPressed: () => Navigator.maybePop(context)),
                  Text(widget.title ?? getMyServicesLabels(context).selectYourLocation),
                  IconButton(
                    icon: const Icon(iconCheckCircle),
                    color: Colors.green,
                    onPressed: () {
                      widget.onLocationPicked(newLat, newLng);
                      Navigator.maybePop(context, <double?>[newLat, newLng]);
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: MyContainer(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 15),
                borderWidth: 1,
                borderColor: Colors.grey,
                borderRadius: MyServices.services.theme.borderRadius,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) => controller.setMapStyle(isDark(context)
                      ? mapStyleDark(
                          getColorScheme(context).background,
                          getColorScheme(context).primary,
                        )
                      : null),
                  onTap: (LatLng latLng) {
                    setState(() {
                      newLat = latLng.latitude;
                      newLng = latLng.longitude;
                    });
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('PickedLocation'),
                      draggable: true,
                      position: LatLng(newLat ?? widget.lat ?? 22, newLng ?? widget.lng ?? 22),
                      infoWindow: InfoWindow(title: getMyServicesLabels(context).location),
                      onDragEnd: (LatLng latLng) {
                        newLat = latLng.latitude;
                        newLng = latLng.longitude;
                      },
                    ),
                  },
                  initialCameraPosition: CameraPosition(zoom: 10, target: LatLng(widget.lat ?? 22, widget.lng ?? 22)),
                ),
              ),
            ),
          ],
        ));
  }
}
