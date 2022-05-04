import 'package:intl/intl.dart';

import '../models/listclass.dart';

import 'package:flutter/material.dart';

class TextFieldPrompt extends StatefulWidget {
  Function _addTransaction;
  DateTime _selectDate;
  List<ListDetail> transactions;
  TextFieldPrompt(this.transactions, this._addTransaction);

  @override
  State<TextFieldPrompt> createState() => _TextFieldPromptState();
}

class _TextFieldPromptState extends State<TextFieldPrompt> {
  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030))
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        widget._selectDate = value;
      });
    });
  }

  var titlecontroller = TextEditingController();

  var amountcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 300,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 6,
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Title', hintText: 'Enter your title here!'),
                controller: titlecontroller,
              ),
            ),
            // const SizedBox(height: 10),
            Card(
              elevation: 6,
              child: TextField(
                controller: amountcontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter your text here',
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget._selectDate == null
                    ? const Text('No date Chosen!')
                    : Text(DateFormat.yMMMd().format(widget._selectDate)),
                ElevatedButton(
                    onPressed: datepicker, child: const Text('Chosse Date'))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => widget._addTransaction(titlecontroller.text,
                      double.parse(amountcontroller.text), widget._selectDate),
                  child: const Text('Add Transactions'),
                ),
              ],
            )
          ],
        ));
  }
}
