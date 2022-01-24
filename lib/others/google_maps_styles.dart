//googleMaps
import '../my_services.dart';

var lightBgColor = "#" + (ServiceTheme.lightBgColor?.value.toRadixString(16) ?? "ffffff");
var lightRoadColor = "#" + (ServiceTheme.lightAccentColor?.value.toRadixString(16) ?? "193a55");

String lightMapStyle() => mapStyleLight(lightBgColor, lightRoadColor);

var darkBgColor = "#" + (ServiceTheme.darkBgColor?.value.toRadixString(16) ?? "161C1E");
var darkRoadColor = "#" + (ServiceTheme.darkAccentColor?.value.toRadixString(16) ?? "193a55");
//
String darkMapStyle() => mapStyleDark(darkBgColor, darkRoadColor);
//
String darkMapStyleStatic() {
  String darkBgColor = ("0x" + (ServiceTheme.darkBgColor?.value.toRadixString(16) ?? "161C1E")).replaceAll("0xff", "");
  String darkRoadColor = ("0x" + (ServiceTheme.darkAccentColor?.value.toRadixString(16) ?? "193a55")).replaceAll("0xff", "");
  return "style=element:geometry%7Ccolor:0x212121&style=element:geometry.fill%7Ccolor:0x$darkBgColor&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x757575&style=element:labels.text.stroke%7Ccolor:0x212121&style=feature:administrative%7Celement:geometry%7Ccolor:0x757575&style=feature:administrative.country%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0x181818&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:poi.park%7Celement:labels.text.stroke%7Ccolor:0x1b1b1b&style=feature:road%7Celement:geometry.fill%7Ccolor:0x2c2c2c&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x8a8a8a&style=feature:road.arterial%7Celement:geometry%7Ccolor:0x373737&style=feature:road.highway%7Celement:geometry%7Ccolor:0x3c3c3c&style=feature:road.highway%7Celement:geometry.fill%7Ccolor:0x$darkRoadColor&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0x4e4e4e&style=feature:road.local%7Celement:geometry.fill%7Ccolor:0x$darkRoadColor&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:water%7Celement:geometry%7Ccolor:0x000000&style=feature:water%7Celement:geometry.fill%7Ccolor:0x033954&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x3d3d3d&size=480x360";
}

String lightMapStyleStatic() {
  String lightRoadColor = ("0x" + (ServiceTheme.lightAccentColor?.value.toRadixString(16) ?? "161C1E")).replaceAll("0xff", "");
  return "style=feature:road.highway%7Celement:geometry.fill%7Ccolor:0x$lightRoadColor&size=480x360";
}

String mapStyleLight(bgColor, roadColor) => '''
[
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#ff7202"
      }
    ]
  }
]
''';

String mapStyleDark(bgColor, roadColor) => '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "$bgColor"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "$roadColor"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "$roadColor"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#033954"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';

//TODO: ref this
String getMapImageFromLatLong(double lat, double lng, String googleMapKey, BuildContext context) {
  String style = isDark(context) ? darkMapStyleStatic() : lightMapStyleStatic();
  String lang = ServiceLocale.currentLocaleLangCode(context);

  String language = 'language=$lang';
  String key = 'key=$googleMapKey';
  final String marker = 'markers=$lat,$lng';
  final String center = 'center=$lat,$lng';
  const String size = 'size=640x640';
  const String zoom = 'zoom=10';
  const String scale = 'scale=2';
  const String maptype = 'roadmap';
  String url = 'https://maps.googleapis.com/maps/api/staticmap?&maptype=$maptype';
  return '$url&$marker&$size&$center&$zoom&$language&$style&$scale&$key';
}
