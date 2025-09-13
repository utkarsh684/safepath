import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String _displayCity = "Your Location";
  bool _loading = false;
  bool _showCurrentLocation = true;

  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  // Dummy current and searched weather data for demonstration
  List<Map<String, dynamic>> weeklyForecast = [
    {
      "day": "Thu",
      "high": 34,
      "low": 25,
      "desc": "Sunny",
      "icon": Icons.wb_sunny,
    },
    {
      "day": "Fri",
      "high": 32,
      "low": 24,
      "desc": "Cloudy",
      "icon": Icons.cloud,
    },
    {
      "day": "Sat",
      "high": 31,
      "low": 23,
      "desc": "Rain",
      "icon": Icons.beach_access,
    },
    {
      "day": "Sun",
      "high": 29,
      "low": 22,
      "desc": "Thunderstorm",
      "icon": Icons.flash_on,
    },
    {
      "day": "Mon",
      "high": 30,
      "low": 23,
      "desc": "Clear",
      "icon": Icons.wb_sunny,
    },
    {"day": "Tue", "high": 32, "low": 24, "desc": "Windy", "icon": Icons.waves},
    {
      "day": "Wed",
      "high": 33,
      "low": 25,
      "desc": "Drizzle",
      "icon": Icons.grain,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController?.forward();
    // TODO: Get user's current location via geolocator, update _displayCity & weather data from API.
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final city = _controller.text.trim();
    if (city.isEmpty) return;
    setState(() {
      _loading = true;
      _showCurrentLocation = false;
      _displayCity = city;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
      _animationController?.forward(from: 0.0);
      // TODO: Replace weeklyForecast with API results for searched city.
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Color(0xFF1976D2);
    final colorSecondary = Color(0xFF64B5F6);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Weather Safety",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 0.8,
          ),
        ),
        backgroundColor: colorPrimary,
        centerTitle: true,
        elevation: 5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorPrimary, colorSecondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorPrimary.withOpacity(0.08),
              colorSecondary.withOpacity(0.09),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Search location (e.g., Mumbai)",
                        prefixIcon: Icon(Icons.search, color: colorPrimary),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 15,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _searchWeather(),
                    ),
                  ),
                  SizedBox(width: 12),
                  if (!_showCurrentLocation)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimary,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                      ),
                      icon: Icon(Icons.my_location, size: 18),
                      label: Text(
                        "Current",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showCurrentLocation = true;
                          _displayCity = "Your Location";
                          // TODO: Load real user's location and weather data.
                        });
                        _animationController?.forward(from: 0.0);
                      },
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: colorPrimary, size: 26),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _displayCity,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                        letterSpacing: 0.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Divider(
                thickness: 1.2,
                color: colorPrimary.withOpacity(0.2),
              ),
            ),
            SizedBox(height: 8),
            _loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 54.0),
                    child: Center(
                      child: CircularProgressIndicator(color: colorPrimary),
                    ),
                  )
                : Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation!,
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: weeklyForecast.length,
                        itemBuilder: (context, idx) {
                          final day = weeklyForecast[idx];
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 350 + idx * 100),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.12),
                                  blurRadius: 9,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 6,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    day["icon"],
                                    color: colorPrimary,
                                    size: 34,
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    day["day"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorPrimary,
                                    ),
                                  ),
                                  Text(
                                    day["desc"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "High: ${day["high"]}°C",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colorPrimary,
                                    ),
                                  ),
                                  Text(
                                    "Low: ${day["low"]}°C",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
