import 'package:demo/AccountPage.dart';
import 'package:demo/AlertsPage.dart';
import 'package:demo/RoutesFinderPage.dart';
import 'package:demo/WeatherPage.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0; // Track selected tab

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Pages for BottomNavigationBar
    final List<Widget> _pages = [
      // Home Page with Card
      Routesfinderpage(),
      // Alerts Page
      AlertsPage(),
      // Weather Page
      WeatherPage(),
      // Account Page
      AccountPage(),
    ];
    return Scaffold(
      body: _pages[_currentIndex], // Show selected page

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: "Weather"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
