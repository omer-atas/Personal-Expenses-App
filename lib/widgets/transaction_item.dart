import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const avaibleColors = [
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.deepPurple,
      Colors.tealAccent,
      Colors.lime,
    ];
    _bgColor = avaibleColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('${widget.transaction.amount} ₺')),
          ),
        ),
        title: Text(widget.transaction.title,
            style: Theme.of(context).textTheme.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
