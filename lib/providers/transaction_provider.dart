import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  String _selectedCategory = 'All';

  List<Transaction> get transactions {
    if (_selectedCategory == 'All') return _transactions;
    return _transactions
        .where((tx) => tx.category == _selectedCategory)
        .toList();
  }

  void addTransaction(Transaction tx) {
    _transactions.add(tx);
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  double get totalExpenses => _transactions
      .where((tx) => tx.amount < 0)
      .fold(0.0, (sum, item) => sum + item.amount.abs());

  double get totalIncome => _transactions
      .where((tx) => tx.amount > 0)
      .fold(0.0, (sum, item) => sum + item.amount);

  double monthlyBudget = 10000;
  double get remainingBudget => monthlyBudget - totalExpenses;
}
