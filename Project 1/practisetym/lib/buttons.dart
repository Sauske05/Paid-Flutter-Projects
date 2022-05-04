import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function buttonclick;
  final String answers;
  Button(this.buttonclick, this.answers);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: buttonclick,
          child: Text(answers),
        ),
      ],
    );
  }
}
