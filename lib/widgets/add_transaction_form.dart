import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Food';

  final categories = ['Food', 'Travel', 'Rent', 'Income'];

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null) return;

    final newTx = Transaction(
      id: Uuid().v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: _selectedCategory,
    );

    Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(newTx);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
              TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount')),
              DropdownButton<String>(
                value: _selectedCategory,
                items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val!;
                  });
                },
              ),
              ElevatedButton(child: Text("Add Transaction"), onPressed: _submitData)
            ],
          ),
        ),
      ),
    );
  }
}
