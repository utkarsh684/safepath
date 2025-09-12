import 'package:flutter/material.dart';

class Routespage extends StatefulWidget {
  const Routespage({
    super.key,
    required this.source,
    required this.destination,
  });
  final String? source;
  final String? destination;

  @override
  State<Routespage> createState() => _RoutespageState();
}

class _RoutespageState extends State<Routespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Routes")),
      body: Column(children: [Text(widget.source!), Text(widget.destination!)]),
    );
  }
}
