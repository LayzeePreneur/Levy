import 'package:flutter/material.dart';
import '../widgets/chartbar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _txList;

  Chart(this._txList);

  List<Transaction> get _recentTransaction {
    var _sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));

    return _txList.where((Transaction tx) {
      return tx.date.isAfter(_sevenDaysAgo);
    }).toList();
  }

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
