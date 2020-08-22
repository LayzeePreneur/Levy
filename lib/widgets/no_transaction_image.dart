import 'package:flutter/material.dart';

class NoTransactionImage extends StatelessWidget {
  final bool _isLandscape;

  const NoTransactionImage(this._isLandscape);

  @override
  Widget build(BuildContext context) {
    final double _imgHeight = _isLandscape ? 0.7 : 0.6;

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              'No Transaction Added Yet!',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/waiting.png',
              height: constraints.maxHeight * _imgHeight,
            ),
          ],
        ),
      );
    });
  }
}
