
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(SmartFlowApp());
}

class SmartFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City X SmartFlow',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194);
  final Map<MarkerId, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMockMarkers();
  }

  void _addMockMarkers() {
    final mockData = [
      {'id': 'plaza', 'lat': 37.7749, 'lng': -122.4194, 'density': 'high'},
      {'id': 'museum', 'lat': 37.776, 'lng': -122.417, 'density': 'medium'},
      {'id': 'cafe', 'lat': 37.775, 'lng': -122.42, 'density': 'low'},
    ];

    for (var location in mockData) {
      final markerId = MarkerId(location['id'] as String);
      final marker = Marker(
        markerId: markerId,
        position: LatLng(location['lat'] as double, location['lng'] as double),
        infoWindow: InfoWindow(
          title: location['id'],
          snippet: 'Density: ${location['density']}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          location['density'] == 'high'
              ? BitmapDescriptor.hueRed
              : location['density'] == 'medium'
                  ? BitmapDescriptor.hueOrange
                  : BitmapDescriptor.hueGreen,
        ),
      );
      _markers[markerId] = marker;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SmartFlow Dashboard')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        markers: Set<Marker>.of(_markers.values),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}


