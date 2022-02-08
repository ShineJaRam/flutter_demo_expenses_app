import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate;
  bool _isDateSelected = false;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0 || _isDateSelected == false) {
      return;
    }

    widget.addTx(
        _titleController.text,
        double.parse(
          _amountController.text,
        ));

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _isDateSelected = true;
        _selectedDate = pickedDate;
      });
    });

    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _isDateSelected == false
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: _presentDatePicker,
                      child: const Text(
                        'Choose Date!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                ),
                onPressed: _submitData,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
