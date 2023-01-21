import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final addTx;

  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleControl = TextEditingController();
  DateTime _selectedDate;
  final amountControl = TextEditingController();

  void submitData() {
    final enteredData = titleControl.text;
    final enteredAmount = double.parse(amountControl.text);
    if (enteredData.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredData, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                // onChanged: (value) => amountInput = value,
                controller: titleControl,
                onSubmitted: (_) => submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                //onChanged: (val) => titleInput = val,
                controller: amountControl,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      (_selectedDate == null
                          ? 'No Date chosen!'
                          : DateFormat.yMd().format(_selectedDate)),
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: datepicker,
                      style: TextButton.styleFrom(
                        primary: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.purple,
                ),
                child: Text("Add Transaction"),
                onPressed: submitData,
              )
            ]),
      ),
    );
  }
}
