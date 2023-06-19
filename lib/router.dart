import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions/add_transaction/add_transaction_page.dart';
import 'package:transactions/auth/view/auth_screen.dart';
import 'package:transactions/home_page/view/home_page.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/transaction_details/view/transaction_details_page.dart';

class AppRouter {
  static late GoRouter router;

  static init(BuildContext context) {
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          name: 'home_page',
          path: '/home_page',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: 'transaction_details',
          path: '/transaction_details',
          builder: (context, state) {
            Transaction transaction = state.extra as Transaction;
            return TransactionDetailsPage(transaction: transaction);
          },
        ),
        GoRoute(
          name: 'add_transaction',
          path: '/add_transaction',
          builder: (context, state) => const AddTransactionPage(),
        ),
      ],
    );
    ;
  }
}
