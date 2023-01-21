import 'package:flutter/material.dart';
import 'package:expense_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> tran;
  final Function deletetx;
  TransactionList(this.tran, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: tran.isEmpty
          ? Column(
              children: <Widget>[
                Text("No transactions are added yet!!"),
                //Image.asset()
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.purple,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(child: Text('${tran[index].cost}')),
                      ),
                    ),
                    title: Text(
                      tran[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(tran[index].date),
                      style: TextStyle(
                        color: Colors.black12,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => deletetx(tran[index].id),
                      icon: Icon(Icons.delete),
                      color: Colors.redAccent,
                    ),
                  ),
                );
              },
              itemCount: tran.length,
            ),
    );
  }
}
