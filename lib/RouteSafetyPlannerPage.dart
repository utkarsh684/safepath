import 'package:flutter/material.dart';

class RouteSafetyPlannerPage extends StatefulWidget {
  @override
  _RouteSafetyPlannerPageState createState() => _RouteSafetyPlannerPageState();
}

class _RouteSafetyPlannerPageState extends State<RouteSafetyPlannerPage> {
  final _formKey = GlobalKey<FormState>();
  String? _source;
  String? _destination;
  String _travelType = 'Train';
  DateTime? _departureDate;

  void _findRoutes() {
    if (_formKey.currentState!.validate() && _departureDate != null) {
      // Call backend or algorithms to generate route options & safety scores
      // For demo, just show some dummy routes
      showModalBottomSheet(
        context: context,
        builder: (_) => _RouteResultsSheet(
          source: _source!,
          destination: _destination!,
          travelType: _travelType,
          departureDate: _departureDate!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plan Your Safe Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Source field
              TextFormField(
                decoration: InputDecoration(labelText: "Source Location"),
                onChanged: (val) => _source = val,
                validator: (val) => val == null || val.isEmpty ? "Enter starting point" : null,
              ),
              SizedBox(height: 12),
              // Destination field
              TextFormField(
                decoration: InputDecoration(labelText: "Destination"),
                onChanged: (val) => _destination = val,
                validator: (val) => val == null || val.isEmpty ? "Enter destination" : null,
              ),
              SizedBox(height: 16),
              // Travel type
              Text("Mode of Travel"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: Text("Train"),
                    selected: _travelType == 'Train',
                    onSelected: (_) => setState(() => _travelType = "Train"),
                  ),
                  ChoiceChip(
                    label: Text("Airplane"),
                    selected: _travelType == 'Airplane',
                    onSelected: (_) => setState(() => _travelType = "Airplane"),
                  ),
                  ChoiceChip(
                    label: Text("Road"),
                    selected: _travelType == 'Road',
                    onSelected: (_) => setState(() => _travelType = "Road"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Date picker
              ListTile(
                title: Text(_departureDate == null
                    ? "Choose Departure Date"
                    : "Departure: ${_departureDate!.toLocal().toString().split(' ')[0]}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _departureDate = picked);
                },
              ),
              SizedBox(height: 28),
              // Find routes button
              ElevatedButton.icon(
                icon: Icon(Icons.search),
                label: Text("Find Safe Routes"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onPressed: _findRoutes,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteResultsSheet extends StatelessWidget {
  final String source, destination, travelType;
  final DateTime departureDate;

  const _RouteResultsSheet({
    required this.source,
    required this.destination,
    required this.travelType,
    required this.departureDate,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data for representative purposes
    final routes = [
      {
        "route": "$source ➔ $destination via Route A",
        "score": 88,
        "details": "Well-maintained, security checks: frequent, landslide risk: low",
      },
      {
        "route": "$source ➔ $destination via Route B",
        "score": 72,
        "details": "Some crime risk, security checks: moderate, landslide risk: medium",
      }
    ];

    return Container(
      padding: EdgeInsets.all(16),
      height: 350,
      child: ListView(
        children: [
          Text("Available Routes", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12),
          ...routes.map((r) => Card(
            child: ListTile(
              leading: Icon(
                travelType == "Train" ? Icons.train :
                travelType == "Airplane" ? Icons.flight : Icons.directions_car,
                color: Colors.blue[800],
                size: 34,
              ),
              title: Text(r["route"] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Safety Score: ${r["score"]}/100", style: TextStyle(
                      color: r["score"] as int > 80 ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold)),
                  Text(r["details"] as String),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text("View Safety Report"),
                      onPressed: () {
                        // Show extremely detailed route report in a new page/sheet
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
