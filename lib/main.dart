import 'dart:async';

import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/expense.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import 'widgets/add_transaction.dart';
import 'widgets/no_transaction_image.dart';

void main() => runApp(PersonalExpenses());

class PersonalExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primarySwatch: Colors.indigo,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                  ),
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline4: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              headline5: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              headline6: const TextStyle(
                fontSize: 16,
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

  const HomeScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> _txList = <Expense>[];
  bool _showChart = false;

  Future<Database> _getDatabase() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'expenses.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses (id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT, amount REAL, date TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }

  Future<List<Expense>> _getTransactions() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> transactions = await db.rawQuery(
      'SELECT * FROM expenses',
    );

    return List.generate(transactions.length, (index) {
      return Expense(
        id: transactions[index]['id'],
        title: transactions[index]['title'],
        amount: transactions[index]['amount'],
        date: DateTime.parse(transactions[index]['date']),
      );
    }).toList();
  }

  Future<void> _loadTransactions() async {
    List<Expense> _getTxList = await _getTransactions();

    setState(() => _txList = _getTxList);
  }

  Future<void> _addNewTx(String title, double amount, DateTime date) async {
    Database db = await _getDatabase();

    await db.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO expenses (title, amount, date) VALUES (?, ?, ?)',
        [title, amount, date.toString()],
      );
    });

    _loadTransactions();
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddTransaction(_addNewTx),
    );
  }

  Future<void> _deleteTransaction(int id) async {
    Database db = await _getDatabase();
    db.rawDelete('DELETE FROM expenses WHERE id = ?', [id]);

    _loadTransactions();
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final bool _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    AppBar _appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddTransaction(context),
        ),
      ],
    );

    double _bodySize = _mediaQuery.size.height -
        _appBar.preferredSize.height -
        _mediaQuery.padding.top;

    List<Widget> _buildPortrait() {
      return <Widget>[
        Container(
          height: _bodySize * 0.3,
          child: Chart(_txList),
        ),
        Container(
          height: _bodySize * 0.7,
          child: _txList.isEmpty
              ? NoTransactionImage(_isLandscape)
              : TransactionList(_txList, _deleteTransaction),
        ),
      ];
    }

    List<Widget> _buildLandscape() {
      return <Widget>[
        Container(
          height: _bodySize * 0.1 + 10,
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Show Chart',
                style: Theme.of(context).textTheme.headline5,
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
                height: _bodySize * 0.8 - 10,
                child: Chart(_txList),
              )
            : Container(
                height: _bodySize * 0.9 - 10,
                child: _txList.isEmpty
                    ? NoTransactionImage(_isLandscape)
                    : TransactionList(_txList, _deleteTransaction),
              ),
      ];
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _appBar,
      body: Column(
        children: <Widget>[
          if (!_isLandscape) ..._buildPortrait(),
          if (_isLandscape) ..._buildLandscape(),
        ],
      ),
    );
  }
}
