import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class TxListItem extends StatelessWidget {
  final Expense txItem;
  final Function handler;

  const TxListItem(this.txItem, this.handler);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(width: 1, color: Colors.grey[300]),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 12,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 62,
                      height: 62,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: FittedBox(
                        child: Text(
                          '\$${txItem.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            txItem.title,
                            style: Theme.of(context).textTheme.headline5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            DateFormat.yMMMEd().format(txItem.date),
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 15,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              mediaQuery.size.width > 450
                  ? FlatButton.icon(
                      icon: Icon(Icons.delete, size: 28),
                      label: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      textColor: Theme.of(context).accentColor,
                      onPressed: () => handler(txItem.id),
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 28,
                      color: Theme.of(context).accentColor,
                      onPressed: () => handler(txItem.id),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
