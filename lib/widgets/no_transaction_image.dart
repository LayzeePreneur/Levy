import 'package:flutter/material.dart';

class NoTransactionImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              height: constraints.maxHeight * 0.7,
            ),
          ],
        ),
      );
    });
  }
}
