import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> _txDetails;
  final double _totalSpending;

  ChartBar(this._txDetails, this._totalSpending);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${_txDetails['amount']}'),
        SizedBox(height: 5),
        Container(
          width: 12,
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
                heightFactor: _totalSpending > 0
                    ? double.parse(_txDetails['amount']) / _totalSpending
                    : 0,
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
        Text(_txDetails['weekDay']),
      ],
    );
  }
}
