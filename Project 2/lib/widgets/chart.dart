import 'package:flutter/material.dart';
import '../models/listclass.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatefulWidget {
  List<Listdetail> recenttransactions;
  Chart(this.recenttransactions);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupedTransactionvalues {
    //[0,1,4,5] if it was List<int>
    // generates 7 lists based on Map that is yet to be given.
    //generates this values when called getter groupedTransactionvalues
    // [{'day' : Tuesday, 'amount' : 15.0},{'day' : Monday, 'amount' : ???},{'day' : Sunday, 'amount' : ???}, ]
    return List.generate(7, (index) {
      //weekDay : DateTime.now() - 0 ( when index is 0).
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;
      for (var i = 0; i < widget.recenttransactions.length; i = i + 1) {
        if (widget.recenttransactions[i].dateTime.day == weekDay.day &&
            widget.recenttransactions[i].dateTime.month == weekDay.month &&
            widget.recenttransactions[i].dateTime.year == weekDay.year) {
          totalsum = totalsum + widget.recenttransactions[i].price;
        }
      }
      print(totalsum);
      return {'day': DateFormat.E().format(weekDay), 'amount': totalsum};
      // 'day' : Tue, 'amount' : 15.0,
    });
  }

  double get totalspending {
    return groupedTransactionvalues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionvalues);
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...groupedTransactionvalues.map((e) {
                // e : { 'day' : Tudesday, 'amount' : ???}
                // if fit : FlexFit.tight , then wrap the child with expanded rather than flexible.
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: e['day'],
                    spendingamount: e['amount'],
                    spendingpctoftotal: totalspending == 0.0
                        ? 0
                        : (e['amount'] as double) / totalspending,
                  ),
                );
              }).toList()
            ],
          ),
        ));
  }
}
