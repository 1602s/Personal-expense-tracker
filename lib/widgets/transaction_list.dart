import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txs = Provider.of<TransactionProvider>(context).transactions;

    return ListView.builder(
      itemCount: txs.length,
      itemBuilder: (ctx, i) {
        final tx = txs[i];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(tx.title),
            subtitle: Text(DateFormat.yMMMd().format(tx.date)),
            trailing: Text(
              '₹${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: tx.amount >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
