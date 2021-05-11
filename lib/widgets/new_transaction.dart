import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  // listen to login user
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    // This media is used to conect https requests and load data from a file
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // Allows to access and compare previous widgets - veri tababnından bilgi almak ve yerni bilgi alma aayrıcaeldeki verileri temizlemek içinde kullanılır..
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // It is often the case to refine listeners or life connections.
    print('dispose()');
    super.dispose();
  }

  // Getting subject and amount values ​​from the user
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    // when datas became , exit from the current situation.
    Navigator.of(context).pop();
  }

  //show calendar screen
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
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() NewTransacion');

    return SingleChildScrollView(
      child: Container(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                // Keyboard  detected using MediaQuery.of(context).viewInsets.bottom
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        AdaptiveFlatButton(
                          'Choose Date ',
                          _presentDatePicker,
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: _submitData,
                    child: Text(
                      'Add Transaction',
                    ),
                    textColor: Theme.of(context).textTheme.button.color,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
