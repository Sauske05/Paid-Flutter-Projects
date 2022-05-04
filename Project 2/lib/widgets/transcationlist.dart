import 'package:flutter/material.dart';
import '../models/listclass.dart';
import 'package:intl/intl.dart';

class TranscationList extends StatelessWidget {
  final List<Listdetail> _transaction;
  Function deletetransaction;
  TranscationList(this._transaction, this.deletetransaction);
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
                      child: Text(
                        '\$${_transaction[index].price}',
                      ),
                    ),
                    title: Text(
                      _transaction[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      // upon using .fomrat, it returns string value of the given datetime.
                      DateFormat.yMMMd().format(_transaction[index].dateTime),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          deletetransaction(_transaction[index].id),
                    ),
                  );
                },
                itemCount: _transaction.length,
              ));
  }
}
