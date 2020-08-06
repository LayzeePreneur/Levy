import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chartbar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _txList;

  Chart(this._txList);

  List<Transaction> get _recentTransaction {
    DateTime _sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));

    return _txList.where((Transaction tx) {
      return tx.date.isAfter(_sevenDaysAgo);
    }).toList();
  }

  List<Map<String, Object>> get _groupedTransaction {
    return List.generate(7, (int index) {
      DateTime _date = DateTime.now().subtract(Duration(days: index));
      double _amount = 0;

      _recentTransaction.forEach((Transaction tx) {
        if (_date.day == tx.date.day) _amount += tx.amount;
      });

      return {
        'amount': _amount.toStringAsFixed(0),
        'weekDay': DateFormat.E().format(_date).substring(0, 1),
      };
    }).reversed.toList();
  }

  double get _sevenDaysAmount {
    return _recentTransaction.fold(0, (prev, elem) {
      return prev + elem.amount;
    });
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
              return ChartBar(_groupedTransaction[index], _sevenDaysAmount);
            }),
          ),
        ),
        margin: const EdgeInsets.all(20),
        elevation: 6,
      ),
    );
  }
}
