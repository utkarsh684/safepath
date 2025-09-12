import 'package:flutter/material.dart';

import 'RoutesPage.dart';
import 'appbar.dart';

class Routesfinderpage extends StatefulWidget {
  const Routesfinderpage({super.key});

  @override
  State<Routesfinderpage> createState() => _RoutesfinderpageState();
}

class _RoutesfinderpageState extends State<Routesfinderpage> {
  String _travelType = 'Train';
  DateTime? _selectedDate;
  final TextEditingController _source = new TextEditingController();
  final TextEditingController _destination = new TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default today
      firstDate: DateTime(2020), // earliest date
      lastDate: DateTime(2100), // latest date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        print(picked);
      });
    }
  }

  void toRoutesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Routespage(source: _source.text, destination: _destination.text),
      ),
    );
  }

  @override
  void dispose() {
    _source.dispose();
    _destination.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Card(
                margin: EdgeInsets.all(20),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade800, width: 1.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _source,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            labelText: "Source",
                            labelStyle: TextStyle(color: Colors.blue),
                            floatingLabelStyle: TextStyle(color: Colors.blue),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icon(Icons.location_on_outlined),
                            hintText: "Leaving From",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _destination,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            labelText: "Destination",
                            labelStyle: TextStyle(color: Colors.blue),
                            floatingLabelStyle: TextStyle(color: Colors.blue),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icon(Icons.add_location_alt_outlined),
                            hintText: "Going To",
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? "Select Date"
                                      : "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(Icons.calendar_today, color: Colors.blue),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 34),
                        Wrap(
                          spacing: 10,
                          children: [
                            ChoiceChip(
                              label: Text("Train"),
                              selected: _travelType == 'Train',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) =>
                                  setState(() => _travelType = "Train"),
                            ),
                            ChoiceChip(
                              label: Text("Airplane"),
                              selected: _travelType == 'Airplane',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) =>
                                  setState(() => _travelType = "Airplane"),
                            ),
                            ChoiceChip(
                              label: Text("Road"),
                              selected: _travelType == 'Road',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) =>
                                  setState(() => _travelType = "Road"),
                            ),
                          ],
                        ),
                        SizedBox(height: 34),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide.none,
                            ),
                            elevation: 8,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            minimumSize: Size(double.infinity, 60),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            if (_source.text.trim().isEmpty ||
                                _destination.text.trim().isEmpty ||
                                _selectedDate == null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Missing Information"),
                                  content: Text(
                                    "Please fill in Source, Destination, and Date to find routes.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              toRoutesPage(context);
                            }
                          },
                          child: Text(
                            "Find Routes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
