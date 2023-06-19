import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/keys.dart';
import 'package:transactions/middleware.dart';
import 'package:transactions/reducer.dart';
import 'package:transactions/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client()
      .setEndpoint(appwriteEndpoint)
      .setProject(appwriteProjectId)
      .setSelfSigned(status: true);

  final store = Store(reducer,
      initialState: AppUnauthenticated(),
      middleware: [AppMiddleware(client: client)]);

  runApp(TransactionsApp(
    store: store,
  ));
}

typedef ConsolePrint = void Function();

class TransactionsApp extends StatefulWidget {
  const TransactionsApp({super.key, required this.store});
  final Store<AppState> store;

  @override
  State<TransactionsApp> createState() => _TransactionsAppState();
}

class _TransactionsAppState extends State<TransactionsApp> {
  @override
  void initState() {
    super.initState();
    AppRouter.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
