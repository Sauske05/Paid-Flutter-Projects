import 'package:flutter/material.dart';

class Finaltext extends StatelessWidget {
  String text;
  int totalscore;
  Function resetbutton;
  Finaltext(this.totalscore, this.resetbutton);

  @override
  Widget build(BuildContext context) {
    if (totalscore < 30) {
      text = 'Nice Nice';
    } else if (totalscore < 35) {
      text = 'Good Good';
    } else {
      text = 'Not Good';
    }
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text),
          Text('Your final score was $totalscore'),
          const SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: resetbutton,
            child: const Text('Reset'),
          )
        ],
      ),
    );
  }
}
