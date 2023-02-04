import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  LatLng initialLocation = const LatLng(37.422131,-122.084801);

  List<LatLng> polygonPoints = const [
    LatLng(23.766315,90.425778),
    LatLng(23.76491,90.424767),
    LatLng(23.761916,90.426862),
    LatLng(23.758532,90.428588),
    LatLng(23.758825,90.429228),
    LatLng(23.763698,90.431324),
  ];

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/pin.png")
        .then((icon) => {
          markerIcon = icon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14
        ),
        markers: {
          Marker(
            markerId: MarkerId("demo"),
            position: LatLng(37.422131,-122.084801),
            draggable: true,
            onDragEnd: (value){

            },
            icon: markerIcon
          )
        },
        // circles: {
        //   Circle(
        //     circleId: CircleId("1"),
        //     center: initialLocation,
        //     radius: 430,
        //     strokeWidth: 2,
        //     fillColor: Color(0xFF006491).withOpacity(0.2)
        //   )
        // },
        polygons: {
          Polygon(
            polygonId: PolygonId("1"),
            points: polygonPoints,
            fillColor: Color(0XFF006491).withOpacity(0.2),
            strokeWidth: 2
          )
        },
      ),
    );
  }
}
