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
        primarySwatch: Colors.indigo,
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
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: 'Test1',
    //   amount: 45.65,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: 'Test2',
    //   amount: 45.65,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTx(String title, double amount, DateTime date) {
    Transaction tx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() => _txList.add(tx));
  }

  void _startAddTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddTransaction(_addNewTx),
    );
  }

  void _deleteTransaction(String id) {
    setState(
      () => _txList.removeWhere((tx) {
        return tx.id == id;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _startAddTransaction,
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.3,
            child: Chart(_txList),
          ),
          Container(
            height: (mediaQuery.size.height -
                    mediaQuery.padding.top -
                    appBar.preferredSize.height) *
                0.7,
            child: _txList.isEmpty
                ? LayoutBuilder(builder: (context, constraints) {
                    return Container(
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
                            height: constraints.maxHeight * 0.7,
                          ),
                        ],
                      ),
                    );
                  })
                : Container(
                    child: ListView.builder(
                      itemCount: _txList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TxListItem(_txList[index], _deleteTransaction);
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _startAddTransaction,
      ),
    );
  }
}
