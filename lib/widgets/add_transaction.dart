import 'package:flutter/material.dart';

import '../global.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: addTxField('Title'),
            // controller: TextEditingController(),
          ),
          SizedBox(height: 15),
          TextField(
            decoration: addTxField('Amount'),
            keyboardType: TextInputType.number,
            // controller: TextEditingController(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'No Date Choosen',
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
                onPressed: () {},
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
