import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$5'),
        SizedBox(height: 5),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[400]),
                  color: Colors.grey[200],
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text('S'),
      ],
    );
  }
}
