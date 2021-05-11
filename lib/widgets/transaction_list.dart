import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  Widget build(BuildContext context) {
    print('build() TransactionList');
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  Text(
                    "No transactions added yet!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Raleway'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList()),
    );
  }
}
