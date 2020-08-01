import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/tx_list_item.dart';
import './widgets/chart.dart';
import './widgets/add_transaction.dart';

void main() => runApp(PersonalExpenses());

class PersonalExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
      home: HomeScreen(title: 'Personal Expenses'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> _txList = <Transaction>[
    Transaction(
      id: DateTime.now().toString(),
      title: 'Test1',
      amount: 45.65,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Test2',
      amount: 45.65,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Test',
      amount: 45.65,
      date: DateTime.now(),
    ),
  ];

  void _addNewTx(String title, double amount) {
    Transaction tx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() => _txList.add(tx));
  }

  void startAddTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddTransaction(_addNewTx),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: startAddTransaction,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Chart(),
          Container(
            child: _txList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'No Transaction Added Yet!',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 15),
                        Image.asset(
                          'assets/images/waiting.png',
                          height: 250,
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: _txList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TxListItem(_txList[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: startAddTransaction,
      ),
    );
  }
}
