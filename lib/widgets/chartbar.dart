import 'package:flutter/material.dart';

import '../global.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> _txDetails;
  final double _highestSpending;

  ChartBar(this._txDetails, this._highestSpending);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: isLandscape
                ? Text(
                    '\$${_txDetails['amount']}',
                    style: chartbarFontLandscape(17),
                  )
                : FittedBox(
                    child: Text(
                      '\$${_txDetails['amount']}',
                      style: chartbarFontPortrait(),
                    ),
                  ),
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
            child: isLandscape
                ? Text(
                    _txDetails['weekDay'],
                    style: chartbarFontLandscape(16),
                  )
                : FittedBox(
                    child: Text(
                      _txDetails['weekDay'],
                      style: chartbarFontPortrait(),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
