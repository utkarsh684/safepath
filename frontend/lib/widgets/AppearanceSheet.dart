import 'package:flutter/material.dart';

class AppearanceSheet extends StatelessWidget {
  const AppearanceSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Appearance",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("🌞 Light Mode"),
          Text("🌙 Dark Mode"),
        ],
      ),
    );
  }
}
