import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TxListItem extends StatelessWidget {
  final Transaction txItem;
  final Function handler;

  const TxListItem(this.txItem, this.handler);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 68,
                      height: 68,
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
                            fontSize: 16,
                            color: Colors.white,
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            DateFormat.yMMMEd().format(txItem.date),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
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
                      icon: Icon(Icons.delete, size: 30),
                      label: Text('Delete', style: TextStyle(fontSize: 16)),
                      textColor: Theme.of(context).accentColor,
                      onPressed: () => handler(txItem.id),
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 30,
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
