import 'package:flutter/material.dart';
import 'package:demo/model/AlertItem.dart';

class AlertsPage extends StatefulWidget {
const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        backgroundColor: Color(0xFF1976D2),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF3F3F9),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: dummyAlerts.length,
          itemBuilder: (context, idx) {
            final alert = dummyAlerts[idx];
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF42A5F5).withOpacity(0.85),
                  child: Icon(getAlertIcon(alert.type), color: Colors.white, size: 28),
                ),
                title: Text(
                  alert.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 17,
                    color: Color(0xFF1976D2),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      alert.description,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 6),
                    Text(
                      formatAlertTime(alert.alertTime),
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
