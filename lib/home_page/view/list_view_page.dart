import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/extensions.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/router.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AppRouter.router.pushNamed('add_transaction');
        },
      ),
      body: StoreConnector<AppState, List<Transaction>?>(
        converter: (store) => store.state.data,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return Column(
              children: [
                Text(
                  'Total Transactions: ${data.length}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final transaction = data[index];
                      return ListItem(transaction: transaction);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt,
                    size: 140,
                    color: Colors.white38,
                  ),
                  Text(
                    'No data available. Try adding new transaction.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.router.pushNamed('transaction_details', extra: transaction);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
        decoration: const BoxDecoration(
          color: Color(0xFF262228),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type: ${transaction.operation_type.name.capitalize()}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text('Transaction no: ${transaction.transaction_number}'),
                  Text('Transaction amount: ${transaction.amount}'),
                ],
              ),
            ),
            const Expanded(child: Icon(Icons.keyboard_arrow_right)),
          ],
        ),
      ),
    );
  }
}
