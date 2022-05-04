import '../models/listclass.dart';
import 'package:flutter/material.dart';

import './textfieldprompt.dart';
import 'package:intl/intl.dart';

class TransactionModelling extends StatelessWidget {
  List<ListDetail> usertransaactions;
  Function deletetransaction;
  TransactionModelling(this.usertransaactions, this.deletetransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (context, count) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text(usertransaactions[count].amount.toString()),
            ),
            title: Text(usertransaactions[count].title),
            subtitle: Text(
                DateFormat.yMMMd().format(usertransaactions[count].datetime)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deletetransaction(usertransaactions[count].id),
            ),
          );
        },
        itemCount: usertransaactions.length,
      ),
    );
  }
}
