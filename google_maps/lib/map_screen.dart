import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;


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
          target: LatLng(37.422131,-122.084801),
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
        }
      ),
    );
  }
}
