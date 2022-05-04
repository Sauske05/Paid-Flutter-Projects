import 'package:flutter/material.dart';
import '../models/listclass.dart';
import 'package:intl/intl.dart';

class TranscationList extends StatelessWidget {
  final List<Listdetail> _transaction;
  TranscationList(this._transaction);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: double.infinity,
        child: _transaction.isEmpty
            ? Column(
                children: [
                  Text(
                    "Add Transactions!",
                    style: TextStyle(fontFamily: 'OuikSand', fontSize: 25),
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/fonts/images/waiting.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$${_transaction[index].price}',
                        ),
                      ),
                    ),
                    title: Column(
                      children: [
                        Text(
                          _transaction[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          // upon using .fomrat, it returns string value of the given datetime.
                          DateFormat.yMMMd()
                              .format(_transaction[index].dateTime),
                        )
                      ],
                    ),
                  );
                },
                itemCount: _transaction.length,
              ));
  }
}
