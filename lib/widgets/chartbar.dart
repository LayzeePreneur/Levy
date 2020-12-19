import 'package:flutter/material.dart';

import '../global.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.txDetails, this.highestSpending);

  final Map<String, Object> txDetails;
  final double highestSpending;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: isLandscape
                ? Text(
                    '\$${txDetails['amount']}',
                    style: chartbarFontLandscape(17),
                  )
                : FittedBox(
                    child: Text(
                      '\$${txDetails['amount']}',
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
                  heightFactor: highestSpending > 0
                      ? double.parse(txDetails['amount']) / highestSpending
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
                    txDetails['weekDay'],
                    style: chartbarFontLandscape(16),
                  )
                : FittedBox(
                    child: Text(
                      txDetails['weekDay'],
                      style: chartbarFontPortrait(),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
