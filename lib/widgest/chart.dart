import 'package:expense_app/widgest/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTranscation;

  Chart(this.recentTranscation);

  List<Map<String, Object>> get weekTran {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(
          Duration(days: index),
        );
        var totalSum = 0.0;
        for (var i = 0; i < recentTranscation.length; i++) {
          if (recentTranscation[i].date.day == weekday.day &&
              recentTranscation[i].date.month == weekday.month &&
              recentTranscation[i].date.year == weekday.year) {
            totalSum += recentTranscation[i].cost;
          }
        }
        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalSum
        };
      },
    );
  }

  double get totalSpend {
    return weekTran.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekTran.map((data) {
            return ChartBar(
              data['day'] as String,
              data['amount'] as double,
              totalSpend == 0.0 ? 0.0 : (data['amount'] as double) / totalSpend,
            );
          }).toList(),
        ),
      ),
    );
  }
}
