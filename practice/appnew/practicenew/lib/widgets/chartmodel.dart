import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  double amountspent;
  double pctamountspent;
  ChartBar(this.label, this.amountspent, this.pctamountspent);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(label),
          Stack(
            children: [
              Container(
                height: 50,
                width: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                heightFactor: pctamountspent,
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
          Text('\$${amountspent.toStringAsFixed(1)}')
        ],
      ),
    );
  }
}
