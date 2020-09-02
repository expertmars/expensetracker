import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitle = TextEditingController();

  final inputAmount = TextEditingController();

  void submitData() {
    final enteredTitle = inputTitle.text;
    final enteredAmount = double.parse(inputAmount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Item Name"),
          controller: inputTitle,
          onSubmitted: (_) {
            submitData();
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Amount"),
          controller: inputAmount,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitData(),
        ),
        FlatButton(
          onPressed: submitData,
          child: Text("Add Transaction"),
          textColor: Colors.purple,
        )
      ],
    );
  }
}
