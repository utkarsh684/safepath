import 'package:flutter/material.dart';

enum AlertType { SevereWeather, Crime, TransitIssue, General }

class AlertItem {
  final String title;
  final String description;
  final DateTime alertTime;
  final AlertType type;

  AlertItem({
    required this.title,
    required this.description,
    required this.alertTime,
    required this.type,
  });
}

// Helper to get icon for alert type
IconData getAlertIcon(AlertType type) {
  switch (type) {
    case AlertType.SevereWeather:
      return Icons.cloud;
    case AlertType.Crime:
      return Icons.security;
    case AlertType.TransitIssue:
      return Icons.train;
    case AlertType.General:
    default:
      return Icons.info;
  }
}

// Pretty format for alert timestamp
String formatAlertTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} hrs ago';
  if (diff.inDays < 5) return '${diff.inDays} days ago';
  return '${time.day}/${time.month}/${time.year}';
}

// Dummy data set for alerts
List<AlertItem> dummyAlerts = [
  AlertItem(
    title: "Heavy Rain Warning",
    description: "Severe rainfall expected in Northeast region. Travel with caution.",
    alertTime: DateTime.now().subtract(Duration(minutes: 20)),
    type: AlertType.SevereWeather,
  ),
  AlertItem(
    title: "Landslide Risk",
    description: "High landslide risk reported on NH-27. Consider alternate routes.",
    alertTime: DateTime.now().subtract(Duration(hours: 2)),
    type: AlertType.SevereWeather,
  ),
  AlertItem(
    title: "Train Delay",
    description: "Express 121 is delayed due to safety checks.",
    alertTime: DateTime.now().subtract(Duration(hours: 4, minutes: 15)),
    type: AlertType.TransitIssue,
  ),
  AlertItem(
    title: "Pickpocketing Alert",
    description: "Incidents reported in Guwahati railway station.",
    alertTime: DateTime.now().subtract(Duration(days: 1, hours: 3)),
    type: AlertType.Crime,
  ),
  AlertItem(
    title: "General Advisory",
    description: "Stay hydrated and carry travel ID for verification.",
    alertTime: DateTime.now().subtract(Duration(days: 2)),
    type: AlertType.General,
  ),
];
