import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/extensions.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/utils.dart';

class TransactionDetailsPage extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF262228),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  buildDateTimeText(
                    text: 'Date:',
                    dateTime: transaction.transaction_date,
                    style: buildTextStyle(),
                  ),
                  Text(
                    'Amount: ${transaction.amount}',
                    style: buildTextStyle(),
                  ),
                  Text(
                    'Commission: ${transaction.commission}',
                    style: buildTextStyle(),
                  ),
                  Text(
                    'Total: ${transaction.total}',
                    style: buildTextStyle(),
                  ),
                  Text(
                    'Transaction Number: ${transaction.transaction_number}',
                    style: buildTextStyle(),
                  ),
                  Text(
                    'Operation Type: ${transaction.operation_type.name.capitalize()}',
                    style: buildTextStyle(),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          StoreConnector<AppState, VoidCallback>(
            converter: (store) {
              return () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Are you sure you want to remove this transaction?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            store.dispatch(RemoveTransactionAction(
                                transaction: transaction));
                          },
                          child: const Text('Confirm'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Abort'),
                        ),
                      ],
                    );
                  },
                );
              };
            },
            builder: (context, callback) {
              return ElevatedButton(
                onPressed: callback,
                child: const Text('Remove Transaction'),
              );
            },
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
}
