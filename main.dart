import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';


void main() {
  runApp(const SmartFlowApp());
}

class SmartFlowApp extends StatelessWidget {
  const SmartFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartFlow Tokyo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MainPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.hdqwalls.com/download/morning-in-tokyo-sd-750x1334.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Tokyo',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Rest of your existing code for MainPage and other screens...


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MapScreen(),
    const RoutesScreen(),
    const DiscoverScreen(),
    const AttractionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SmartFlow Tokyo')),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.directions), label: 'Routes'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Discover'),
        BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Attractions'),
  ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
),

    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  final List<Map<String, String>> events = const [
    {
      'title': 'Shibuya Street Dance Fest',
      'date': 'April 10, 2025',
      'location': 'Shibuya Crossing, Tokyo',
      'lat': '35.6595',
      'lng': '139.7004',
      'summary': 'A live street dance performance featuring Tokyo’s top artists.',
      'tips': 'Arrive early for a good view. Bring cash for local vendors.',
      'image': 'https://th.bing.com/th/id/R.8a6ff775c7d78d3cb2913dfced43b0bf?rik=gbgiXQiO8fSLJg&riu=http%3a%2f%2fwww.tokyoweekender.com%2fwp-content%2fuploads%2f2017%2f11%2fshibuya-street-dance.jpg&ehk=qOpBnux7INRCDOnJ3WXceGgJZlM67q0XyxqmtRrhBrI%3d&risl=&pid=ImgRaw&r=0'
    },
    {
      'title': 'Ueno Sakura Festival',
      'date': 'April 12, 2025',
      'location': 'Ueno Park, Tokyo',
      'lat': '35.7156',
      'lng': '139.7745',
      'summary': 'Celebrate cherry blossom season with food stalls and live music.',
      'tips': 'Wear comfortable shoes and bring a picnic mat.',
      'image': 'https://cdn.cheapoguides.com/wp-content/uploads/sites/2/2019/03/ueno-park-cherry-blossoms_gdl-1024x600.jpg'
    },
    {
      'title': 'Asakusa Cultural Parade',
      'date': 'April 14, 2025',
      'location': 'Asakusa, Tokyo',
      'lat': '35.7148',
      'lng': '139.7967',
      'summary': 'Traditional costumes, music, and performances.',
      'tips': 'Best viewed from the Kaminarimon gate side.',
      'image': 'https://thumbs.dreamstime.com/b/tokyo-asakusa-samba-carnival-tokyo-aug-participants-asakusa-samba-carnival-tokyo-japan-august-asakusa-samba-134118592.jpg'
    },
  ];

  void _openInMaps(String lat, String lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            leading: Image.network(event['image']!, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(event['title']!),
            subtitle: Text('Date: ${event['date']}\nLocation: ${event['location']}'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Summary: ${event['summary']}'),
                    Text('Know Before You Go: ${event['tips']}'),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.map),
                      label: const Text("Open in Maps"),
                      onPressed: () => _openInMaps(event['lat']!, event['lng']!),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    const CameraPosition initialPosition = CameraPosition(
      target: LatLng(35.682839, 139.759455), // Tokyo center
      zoom: 12,
    );
    
    final Set<Circle> densityCircles = {
      Circle(
        circleId: const CircleId("shibuya"),
        center: const LatLng(35.6595, 139.7004),
        radius: 600, // High crowd level - larger radius
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeColor: Colors.red,
        strokeWidth: 2,
      ),
      Circle(
        circleId: const CircleId("ueno"),
        center: const LatLng(35.7156, 139.7745),
        radius: 450, // Moderate crowd level - medium radius
        fillColor: Colors.orangeAccent.withOpacity(0.5),
        strokeColor: Colors.orange,
        strokeWidth: 2,
      ),
      Circle(
        circleId: const CircleId("asakusa"),
        center: const LatLng(35.7148, 139.7967),
        radius: 300, // Low crowd level - smaller radius
        fillColor: Colors.yellowAccent.withOpacity(0.5),
        strokeColor: Colors.yellow,
        strokeWidth: 2,
      ),
    };
    
    return GoogleMap(
      initialCameraPosition: initialPosition,
      circles: densityCircles,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
    );
  }
}


class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  final List<Map<String, String>> sampleRoutes = const [
    {
      'route': 'Shinjuku → Shibuya → Ebisu (Yamanote Line)',
      'crowd': 'High',
      'suggested': 'Try Fukutoshin Line: Shinjuku-sanchome → Shibuya → Ebisu (Less crowded)'
    },
    {
      'route': 'Tokyo → Ueno → Akihabara (Yamanote Line)',
      'crowd': 'Moderate',
      'suggested': 'Try Hibiya Line: Tokyo → Hibiya → Akihabara'
    },
    {
      'route': 'Ginza → Asakusa (Ginza Line)',
      'crowd': 'Low',
      'suggested': 'Efficient as is'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sampleRoutes.length,
      itemBuilder: (context, index) {
        final route = sampleRoutes[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(route['route']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Crowd Level: ${route['crowd']}'),
                Text('Suggested: ${route['suggested']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AttractionsScreen extends StatelessWidget {
  const AttractionsScreen({super.key});

  final List<Map<String, dynamic>> attractions = const [
    {
      'name': 'Tokyo Tower',
      'times': [1, 2, 3, 4, 5, 6, 7, 7, 8, 7, 8, 9, 9],
      'currentHour': 4, // This would be dynamically determined in a real app
      'status': 'Usually a little busy'
    },
    {
      'name': 'Meiji Shrine',
      'times': [1, 2, 3, 4, 7, 8, 9, 8, 7, 6, 4, 3, 2],
      'currentHour': 7,
      'status': 'Typically very busy'
    },
    {
      'name': 'Tsukiji Outer Market',
      'times': [4, 3, 2, 5, 7, 9, 9, 7, 6, 5, 4, 3, 3],
      'currentHour': 2,
      'status': 'Not too busy'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attractions.length,
      itemBuilder: (context, index) {
        final place = attractions[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(title: Text(place['name'])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Popular times', style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            children: const [
                              Text('Tuesdays', style: TextStyle(fontSize: 14)),
                              Icon(Icons.arrow_drop_down, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.people, color: Colors.blue, size: 16),
                          const SizedBox(width: 4),
                          Text('${place['currentHour'] + 6} pm: ${place['status']}', 
                              style: const TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(place['times'].length, (i) {
                              final height = place['times'][i] * 5.0;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: height,
                                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                    decoration: BoxDecoration(
                                      color: i == place['currentHour'] ? Colors.blue : Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('6am', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('9am', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('12pm', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('3pm', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('6pm', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('9pm', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
