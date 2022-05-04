import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtransaction;
  NewTransaction(this.addtransaction) {
    print('COnstruct new Transaction ');
  }

  @override
  State<NewTransaction> createState() {
    print('Create State');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final body = Container();
  var textcontroller = TextEditingController();
  DateTime _selectdate;
  var amountcontroller = TextEditingController();

  @override
  void initState() {
    print('init state');
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('did update');
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    // TODO: implement dispose
    super.dispose();
  }

  void onSubmitted() {
    if (textcontroller == null ||
        amountcontroller == null ||
        _selectdate == null)
    // _selectdate == null)
    {
      return;
    }
    widget.addtransaction(
        textcontroller.text, double.parse(amountcontroller.text), _selectdate);

    Navigator.of(context).pop();
  }

  void dateselector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2030))
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectdate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 15,
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: 'Input title here', labelText: 'Title'),
                controller: textcontroller,
                // onSubmitted: (val) => onSubmitted,
                // onChanged: (value) {
                //   titletext = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Price', hintText: 'Input your prices here!'),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                // onSubmitted: (val) => onSubmitted,
                // onChanged: (value) => amounttext = value,
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(_selectdate == null
                    ? 'No Date Added Yet!'
                    : DateFormat.yMd().format(_selectdate)),
                RaisedButton(
                  onPressed: dateselector,
                  child: Text(
                    'Pick a Date!',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  onPressed: onSubmitted,
                  // onPressed: () {
                  //   widget.addtransaction(
                  //       textcontroller.text, double.parse(amountcontroller.text));
                  // },
                  child: Text(
                    'Add Transcations',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
