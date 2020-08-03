import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global.dart';

class AddTransaction extends StatefulWidget {
  final Function handler;

  AddTransaction(this.handler);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    void _startDatePicker() {
      showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        initialDate: DateTime.now(),
      ).then((date) => setState(() => _selectedDate = date));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: addTxField('Title'),
            controller: titleController,
          ),
          SizedBox(height: 15),
          TextField(
            decoration: addTxField('Amount'),
            keyboardType: TextInputType.number,
            controller: amountController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedDate == null
                    ? 'No Date Choosen'
                    : 'Picked Date: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FlatButton(
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: _startDatePicker,
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(fontSize: 16),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () => widget.handler(
                titleController.text,
                double.parse(amountController.text),
                _selectedDate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
