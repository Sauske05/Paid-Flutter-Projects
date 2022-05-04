import 'package:flutter/material.dart';
import './models/listclass.dart';
import './widgets/textfieldprompt.dart';
import './widgets/transactionmodeling.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ListDetail> _usertransaction = [
    ListDetail(
        id: DateTime.now().toString(),
        title: 'Burger',
        amount: 1.99,
        datetime: DateTime.now()),
    // ListDetail()
  ];

  void _addtransactions(String title, double amount, DateTime _selectdate) {
    ListDetail newtransaction = ListDetail(
        amount: amount,
        datetime: _selectdate,
        title: title,
        id: DateTime.now().toString());
    setState(() {
      _usertransaction.add(newtransaction);
    });
  }

  void _deletetransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var press = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Transaction App',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Switch(
            value: press,
            onChanged: (newval) {
              setState(() {
                press = newval;
              });
            },
          ),
        ));
  }
}
