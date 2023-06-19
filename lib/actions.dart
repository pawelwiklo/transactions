import 'package:appwrite/models.dart';
import 'package:transactions/models/transaction.dart';

class LogInAction {
  final String email;
  final String password;

  LogInAction({required this.email, required this.password});
}

class CreateUserSession {
  final Session? session;
  final String? userEmail;

  CreateUserSession({this.session, this.userEmail});
}

class CreateAccount {
  final String email;
  final String password;

  CreateAccount({required this.email, required this.password});
}

class AuthErrorAction {
  final String errorMessage;
  final bool showErrorMessage;

  AuthErrorAction({required this.errorMessage, required this.showErrorMessage});
}

class FetchDataAction {}

class FailureAction {
  final String errorMessage;

  FailureAction({required this.errorMessage});
}

class DataFetchedAction {
  final List<Transaction> data;

  DataFetchedAction({required this.data});
}

class RemoveTransactionAction {
  Transaction transaction;

  RemoveTransactionAction({required this.transaction});
}

class AddTransactionAction {
  Transaction transaction;

  AddTransactionAction({required this.transaction});
}

class TransactionsListUpdated {
  List<Transaction> transactions;

  TransactionsListUpdated({required this.transactions});
}
