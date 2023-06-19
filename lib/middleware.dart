import 'package:appwrite/appwrite.dart';
import 'package:redux/redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/keys.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/router.dart';

class AppMiddleware implements MiddlewareClass<AppState> {
  final Client client;

  AppMiddleware({required this.client});

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LogInAction) {
      await logIn(store: store, email: action.email, password: action.password);
    } else if (action is CreateAccount) {
      await createAccount(
          store: store, email: action.email, password: action.password);
    } else if (action is FetchDataAction) {
      fetchData(store);
    } else if (action is RemoveTransactionAction) {
      removeTransaction(store, action.transaction);
    } else if (action is AddTransactionAction) {
      addTransaction(store, action.transaction);
    }

    next(action);
  }

  logIn({
    required Store store,
    required String email,
    required String password,
  }) async {
    Account account = Account(client);

    try {
      final session =
          await account.createEmailSession(email: email, password: password);
      store.dispatch(CreateUserSession(session: session, userEmail: email));
      fetchData(store);
      AppRouter.router.goNamed('home_page');
    } on AppwriteException catch (e) {
      store.dispatch(
        AuthErrorAction(errorMessage: e.message!, showErrorMessage: true),
      );
    }
  }

  createAccount({
    required Store store,
    required String email,
    required String password,
  }) async {
    Account account = Account(client);

    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: email,
      );
      final session =
          await account.createEmailSession(email: email, password: password);
      store.dispatch(CreateUserSession(session: session, userEmail: email));
      AppRouter.router.goNamed('home_page');
      fetchData(store);
    } on AppwriteException catch (e) {
      store.dispatch(
        AuthErrorAction(errorMessage: e.message!, showErrorMessage: true),
      );
    }
  }

  void fetchData(Store store) async {
    try {
      final databases = Databases(client);
      final documents = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [],
      );

      List<Transaction> transactions =
          documents.documents.map((t) => Transaction.fromJson(t.data)).toList();
      store.dispatch(DataFetchedAction(data: transactions));
    } on AppwriteException catch (e) {
      store.dispatch(FailureAction(errorMessage: e.message!));
    }
  }

  void removeTransaction(Store store, Transaction transaction) {
    final List<Transaction>? transactions = store.state.data;

    if (transactions != null) {
      final List<Transaction> updatedTransactions =
          List<Transaction>.from(transactions)..remove(transaction);
      store
          .dispatch(TransactionsListUpdated(transactions: updatedTransactions));

      final databases = Databases(client);
      databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: transaction.id,
      );

      AppRouter.router.pop();
    }
  }

  void addTransaction(Store store, Transaction transaction) {
    try {
      final List<Transaction>? transactions = store.state.data;

      if (transactions != null) {
        final List<Transaction> updatedTransactions =
            List<Transaction>.from(transactions)..add(transaction);
        store.dispatch(
            TransactionsListUpdated(transactions: updatedTransactions));

        final databases = Databases(client);
        databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: transaction.id,
          data: transaction.toJson(),
        );

        AppRouter.router.pop();
      }
    } on Exception catch (_) {
      store
          .dispatch(FailureAction(errorMessage: 'Please validate all fields.'));
    }
  }
}
