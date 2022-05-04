import 'package:flutter/material.dart';
import 'package:transcationapp/widgets/chart.dart';

class ChartBar extends StatelessWidget {
  final mainbody = Container();
  String label;
  double spendingamount;
  double spendingpctoftotal;

  ChartBar({this.label, this.spendingamount, this.spendingpctoftotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                heightFactor: spendingpctoftotal,
                child: Container(
                  // height: spendingpctoftotal,
                  width: 10,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
        Text('\$${spendingamount.toStringAsFixed(1)}'),
      ],
    );
  }
}
