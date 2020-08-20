import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> _txDetails;
  final double _highestSpending;

  ChartBar(this._txDetails, this._highestSpending);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('\$${_txDetails['amount']}')),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            width: 12,
            height: constraints.maxHeight * 0.6,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey[350]),
                    color: Colors.grey[200],
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: _highestSpending > 0
                      ? double.parse(_txDetails['amount']) / _highestSpending
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
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(_txDetails['weekDay'])),
          ),
        ],
      );
    });
  }
}
