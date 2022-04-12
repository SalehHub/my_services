//googleMaps
import 'dart:ui' as ui;

import '../my_services.dart';

StateProvider<Set<Marker>> _markersProvider = StateProvider<Set<Marker>>((ref) => {});

class GoogleMapsCluster<T extends ClusterItem> {
  final WidgetRef _ref;
  final Function(T cluster)? _onMarkerTap;
  final Function(Iterable<T> cluster)? _onMultiMarkersTap;
  final Future<BitmapDescriptor> Function(Iterable<T> cluster, bool isCluster)? _markerIconBuilder;

  ClusterManager<T>? _manager;

  GoogleMapsCluster(this._ref, this._onMarkerTap, this._onMultiMarkersTap, this._markerIconBuilder) {
    _manager ??= ClusterManager<T>(<T>[], _updateMarkers, markerBuilder: _markerBuilder);
  }

  void setItems(List<T> items) {
    _manager?.setItems(items);
  }

  void setMapId(int mapId, {bool withUpdate = true}) async {
    _manager?.setMapId(mapId);
  }

  void onCameraMove(CameraPosition position, {forceUpdate = false}) {
    _manager?.onCameraMove(position, forceUpdate: forceUpdate);
  }

  void updateMap() {
    _manager?.updateMap();
  }

  void _updateMarkers(Set<Marker> _markers) {
    _ref.read(_markersProvider.state).update((state) => _markers);
  }

  Set<Marker> watchMarkers() {
    return _ref.watch(_markersProvider);
  }

  Future<Marker> Function(Cluster<T>) get _markerBuilder => (Cluster<T> cluster) async {
        BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
        if (_markerIconBuilder != null) {
          icon = await _markerIconBuilder!(cluster.items, cluster.isMultiple);
        }

        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          icon: icon,
          onTap: () {
            if (cluster.items.length == 1) {
              if (_onMarkerTap != null) {
                _onMarkerTap!(cluster.items.first);
              }
            } else if (cluster.items.length > 1) {
              if (_onMultiMarkersTap != null) {
                _onMultiMarkersTap!(cluster.items);
              }
            }
          },
        );
      };

  Future<BitmapDescriptor> buildClusterMarker({String text = '', Color bgColor = Colors.red, Color fgColor = Colors.white}) async {
    const int size = 120;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = bgColor;
    final Paint paint2 = Paint()..color = fgColor;

    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.1, paint2);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.4, paint1);

    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: size / 4, color: fgColor, fontWeight: FontWeight.normal),
    );

    painter.layout();

    painter.paint(canvas, Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2));

    final ui.Image img = await pictureRecorder.endRecording().toImage(size, size);

    final ByteData? data = await img.toByteData(format: ui.ImageByteFormat.png);

    if (data == null) {
      return BitmapDescriptor.defaultMarker;
    }

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }
}

class ServiceGoogleMapsCluster {
  GoogleMapsCluster<T> register<T extends ClusterItem>(
    WidgetRef ref, {
    Function(T cluster)? onMarkerTap,
    Function(Iterable<T> cluster)? onMultiMarkersTap,
    Future<BitmapDescriptor> Function(Iterable<T> cluster, bool isCluster)? markerIconBuilder,
  }) {
    return GoogleMapsCluster<T>(ref, onMarkerTap, onMultiMarkersTap, markerIconBuilder);
  }
}
