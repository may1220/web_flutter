import 'package:flutter/material.dart';

class RangeSliderPage extends StatefulWidget {
  RangeSliderPage({super.key});

  @override
  State<RangeSliderPage> createState() => _RangeSliderPageState();
}

class _RangeSliderPageState extends State<RangeSliderPage> {
  double startval = 0, endval = 0.5;

  double startval1 = 20, endval1 = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RangeSlider(
            min: 0,
            max: 100,
            divisions: 10, //slide interval
            labels: RangeLabels("Rs. $startval1", "Rs. $endval1"),
            values: RangeValues(startval1, endval1),
            onChanged: (RangeValues value) {
              setState(() {
                startval1 = value.start;
                endval1 = value.end;
              });
            },
          )
        ],
      ),
    );
  }
}
