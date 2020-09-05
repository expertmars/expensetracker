import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitle = TextEditingController();

  final inputAmount = TextEditingController();

  DateTime _pickedDate;

  void _submitData() {
    if (inputAmount.text.isEmpty) {
      return;
    }
    final enteredTitle = inputTitle.text;
    final enteredAmount = double.parse(inputAmount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _pickedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
    print("...");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Item Name"),
            controller: inputTitle,
            onSubmitted: (_) {
              _submitData();
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: inputAmount,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Text(_pickedDate == null
                    ? "No date chosen!"
                    : "Picked Date: ${DateFormat.yMd().format(_pickedDate)}"),
                FlatButton(
                  child: Text("Pick a date"),
                  onPressed: _presentDatePicker,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: _submitData,
            child: Text("Add Transaction"),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).buttonColor,
          )
        ],
      ),
    );
  }
}
