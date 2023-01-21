import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgest/chart.dart';
import 'package:expense_app/widgest/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/widgest/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _tran = [
    // Transactions(
    //   id: "1",
    //   title: "Shoes",
    //   cost: 2500,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: "2",
    //   title: "Clothes",
    //   cost: 5000,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;
  List<Transactions> get _recentTransactions {
    return _tran.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosendate) {
    final newTran = Transactions(
        id: DateTime.now().toString(),
        title: title,
        cost: amount,
        date: chosendate);

    setState(() {
      _tran.add(newTran);
    });
  }

  void _startaddNewTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactions(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deletetx(String id) {
    setState(() {
      _tran.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isL = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Expenditure"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startaddNewTransactions(context),
        )
      ],
    );
    final txList = Container(
      child: TransactionList(_tran, _deletetx),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.6,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isL)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Show Chart"),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isL)
              Container(
                width: double.infinity,
                child: Card(
                  child: Container(
                    child: Chart(_recentTransactions),
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                  ),
                  color: Colors.lightBlue,
                ),
              ),
            if (!isL) txList,
            if (isL)
              (_showChart)
                  ? Container(
                      width: double.infinity,
                      child: Card(
                        child: Container(
                          child: Chart(_recentTransactions),
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.6,
                        ),
                        color: Colors.lightBlue,
                      ),
                    )
                  : txList,
          ],
        ),
      ),
    );
  }
}
