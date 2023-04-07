import 'package:flutter/material.dart';
import 'package:testing_app/graph/graph.dart';

class GraphHome extends StatefulWidget {
  const GraphHome({super.key});

  @override
  State<GraphHome> createState() => _GraphHomeState();
}

class _GraphHomeState extends State<GraphHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LineChartSample4(),
    );
  }
}
