import 'package:flutter/material.dart';
import './widgets/chart.dart';

void main() => runApp(PersonalExpenses());

class PersonalExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(title: 'Personal Expenses'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Chart(),
        ],
      ),
    );
  }
}
