import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'tx_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<Expense> _txList;
  final Function _deleteTransaction;

  const TransactionList(this._txList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 5),
        itemCount: _txList.length,
        itemBuilder: (BuildContext context, int index) {
          return TxListItem(_txList[index], _deleteTransaction);
        },
      ),
    );
  }
}
