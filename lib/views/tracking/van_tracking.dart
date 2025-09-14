import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class VanTracking extends StatefulWidget {
  const VanTracking({Key? key}) : super(key: key);

  @override
  State<VanTracking> createState() => _VanTrackingState();
}

class _VanTrackingState extends State<VanTracking> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng dastination = LatLng(37.33429383, -122.06600055);
  static const LatLng lot1Position = LatLng(47.438971, -122.323794);
  static const LatLng lot2Position = LatLng(47.478121, -122.316434);
  static const LatLng island1Position = LatLng(47.445297, -122.300062);
  static const LatLng island3Position = LatLng(47.442104, -122.300577);

  BitmapDescriptor lot1Icon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor lot2Icon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor island1Icon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor island3Icon = BitmapDescriptor.defaultMarker;
  List<LatLng> polylineCoordinates = [];

  getChannelData() async {
    var res = await http.get(Uri.parse(
        "http://34.223.163.20/socket.io/?EIO=3&transport=polling&t=OTqIXr5"));
    // var body = jsonDecode(res.body);
    print(res.toString());
    // final wsUrl = Uri.parse(
    //     'ws://34.223.163.20/socket.io/?EIO=3&transport=polling&t=OTqIXr5');
    // var channel = WebSocketChannel.connect(wsUrl);
    // channel.stream.listen((message) {
    //   setState(() {
    //     print("object");

    //     print(message.toString());
    //   });
    // });
  }

  void getPolypoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDz92Bgq4J9TRG87K_sGfgLHYB_gR68BoY',
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(dastination.latitude, dastination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/lot1-pin.png')
        .then((icon) {
      lot1Icon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/lot2-pin.png')
        .then((icon) {
      lot2Icon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/island-1.png')
        .then((icon) {
      island1Icon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/island-3.png')
        .then((icon) {
      island3Icon = icon;
    });
  }

  @override
  void initState() {
    setCustomMarkerIcon();
    getPolypoints();
    // getChannelData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          const CameraPosition(target: island1Position, zoom: 13.0),
      polylines: {
        Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.redAccent,
            width: 6)
      },
      markers: {
        const Marker(
            markerId: MarkerId('destination'), position: sourceLocation),
        const Marker(markerId: MarkerId('source'), position: dastination),
        Marker(
          markerId: const MarkerId('lot1'),
          icon: lot1Icon,
          position: lot1Position,
        ),
        Marker(
          markerId: const MarkerId('lot2'),
          icon: lot2Icon,
          position: lot2Position,
        ),
        Marker(
          markerId: const MarkerId('island-1'),
          icon: island1Icon,
          position: island1Position,
        ),
        Marker(
          markerId: const MarkerId('island-3'),
          icon: island3Icon,
          position: island3Position,
        ),
      },
    );
  }
}
