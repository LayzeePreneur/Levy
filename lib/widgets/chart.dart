import 'package:flutter/material.dart';
import '../widgets/chartbar.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return ChartBar();
            }),
          ),
        ),
        margin: const EdgeInsets.all(20),
        elevation: 6,
      ),
    );
  }
}
