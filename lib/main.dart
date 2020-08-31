import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
    );
  }
}
//One test change

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputTitle = TextEditingController();
  final inputAmount = TextEditingController();

  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "Shoes",
      amount: 12.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Mobile Phone",
      amount: 150.00,
      date: DateTime.now(),
    ),
  ];

  void _dataSubmit() {
    String textData = inputTitle.text;
    double amountData = double.parse(inputAmount.text);

    if (textData == null || amountData <= 0) {
      return;
    }

    _newTransaction(
      textData,
      amountData,
    );

    Navigator.of(context).pop();
  }

  void _newTransaction(String txTitle, double txAmount) {
    final newTx = new Transaction(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Item Name"),
                  controller: inputTitle,
                  onSubmitted: (_) {
                    _dataSubmit();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: inputAmount,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _dataSubmit(),
                ),
                FlatButton(
                  onPressed: _dataSubmit,
                  child: Text("Add Transaction"),
                  textColor: Colors.purple,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New App"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddTransaction(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddTransaction(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Card(
                  child: Text("CHART"),
                  color: Colors.amber,
                ),
              ),
              TransactionList(_userTransactions),
            ]),
      ),
    );
  }
}
