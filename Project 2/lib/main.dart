import 'package:flutter/material.dart';
import './widgets/chart.dart';

import 'widgets/NewTransaction.dart';
import './widgets/transcationlist.dart';
import './models/listclass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(titleTextStyle: TextStyle(fontFamily: 'OpenSans')),
          accentColor: Colors.amber,
          primarySwatch: Colors.purple,
          fontFamily: 'OpenSans'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Listdetail> _usertransactions = [
    Listdetail(
        id: 'Arun', price: 1.99, title: 'Burger', dateTime: DateTime.now()),
    // Listdetail(
    //     id: 'Barun', price: 0.99, title: 'Tacos', dateTime: DateTime.now()),
  ];
  List<Listdetail> get _recenttransactions {
    return _usertransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addtransaction(String title, double amount, DateTime selecteddate) {
    var newlist = Listdetail(
        id: DateTime.now().toString(),
        price: amount,
        title: title,
        dateTime: selecteddate);

    setState(() {
      _usertransactions.add(newlist);
    });
  }

  void textFieldpopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTransaction(_addtransaction);
        });
  }
  // String titletext;
  // String amounttext;

  void _deletetransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((element) => element.id == id);
    });
  }

  var press = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => textFieldpopup(context),
      ),
      appBar: AppBar(
        title: const Text('Personal Expenses App'),
        actions: [
          IconButton(
              onPressed: () => textFieldpopup(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Chart(_recenttransactions)),
            // NewTransaction(_addtransaction),
            Container(
                height: MediaQuery.of(context).size.width * 0.7,
                child: TranscationList(_usertransactions, _deletetransaction)),
          ],
        ),
      ),
      // body: Center(
      //   child: Switch(
      //     value: press,
      //     onChanged: (newval) {
      //       setState(() {
      //         press = newval;
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
