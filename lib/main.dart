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

  bool _showChart = false;

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
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    AppBar appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _startAddTransaction,
        ),
      ],
    );

    List<Widget> _buildPortrait() {
      return [
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
              ? NoTransactionImage()
              : TransactionList(_txList, _deleteTransaction),
        ),
      ];
    }

    List<Widget> _buildLandscape() {
      return [
        Container(
          height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.1 +
              10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Show Chart',
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch.adaptive(
                value: _showChart,
                onChanged: (value) => setState(() => _showChart = value),
              ),
            ],
          ),
        ),
        _showChart
            ? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.8,
                child: Chart(_txList),
              )
            : Container(
                height: (mediaQuery.size.height -
                            mediaQuery.padding.top -
                            appBar.preferredSize.height) *
                        0.9 -
                    10,
                child: _txList.isEmpty
                    ? NoTransactionImage()
                    : TransactionList(_txList, _deleteTransaction),
              ),
      ];
    }

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          if (!isLandscape) ..._buildPortrait(),
          if (isLandscape) ..._buildLandscape(),
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

class NoTransactionImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
    });
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> _txList;
  final Function _deleteTransaction;

  TransactionList(this._txList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: ListView.builder(
        itemCount: _txList.length,
        itemBuilder: (BuildContext context, int index) {
          return TxListItem(_txList[index], _deleteTransaction);
        },
      ),
    );
  }
}
