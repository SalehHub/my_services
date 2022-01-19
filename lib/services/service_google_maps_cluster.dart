import 'dart:ui' as ui;

import '../my_services.dart';

StateProvider<Set<Marker>> _markersProvider = StateProvider<Set<Marker>>((ref) => {});

class ServiceGoogleMapsCluster<T extends ClusterItem> {
  ServiceGoogleMapsCluster(this._ref);

  final WidgetRef _ref;

  ClusterManager<T>? _manager;
  Function(T cluster)? _onMarkerTap;
  Function(Iterable<T> cluster)? _onMultiMarkersTap;
  Future<BitmapDescriptor> Function(Iterable<T> cluster, bool isCluster)? _markerIconBuilder;

  void register({
    Function(T cluster)? onMarkerTap,
    Function(Iterable<T> cluster)? onMultiMarkersTap,
    Future<BitmapDescriptor> Function(Iterable<T> cluster, bool isCluster)? markerIconBuilder,
  }) {
    _manager ??= ClusterManager<T>(
      <T>[],
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );

    _onMarkerTap = onMarkerTap;
    _onMultiMarkersTap = onMultiMarkersTap;
    _markerIconBuilder = markerIconBuilder;
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

  Future<BitmapDescriptor> buildClusterMarker({String text = '', Color color = Colors.red}) async {
    const int size = 120;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.1, paint2);
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.4, paint1);

    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: text,
      style: const TextStyle(fontSize: size / 4, color: Colors.white, fontWeight: FontWeight.normal),
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
}
