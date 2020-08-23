import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../global.dart';

class AddTransaction extends StatefulWidget {
  final Function handler;

  const AddTransaction(this.handler);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var _titleController = TextEditingController();
  var _amountController = TextEditingController();
  DateTime _selectedDate;

  void _startDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((date) {
      if (date == null)
        return;
      else
        setState(() => _selectedDate = date);
    });
  }

  void _addTx() {
    var _enteredText = _titleController.text;
    var _enteredAmount = double.parse(_amountController.text);

    if (_enteredText.isEmpty ||
        _enteredAmount.isNaN ||
        _enteredAmount <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.handler(_enteredText, _enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 45,
          left: 25,
          right: 25,
          bottom: MediaQuery.of(context).viewInsets.bottom + 90,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: addTxField('Title'),
              controller: _titleController,
              onSubmitted: (_) => _addTx(),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: addTxField('Amount'),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _addTx(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat('dd/MM/yy').format(_selectedDate)}',
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Quicksand',
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 0.4,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () => _startDatePicker(context),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: const Text(
                  'Add Transaction',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: _addTx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
