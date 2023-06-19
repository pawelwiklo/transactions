import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/auth/view/create_account_view.dart';
import 'package:transactions/auth/view/login_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Log In',
              ),
              Tab(
                text: 'Create account',
              ),
            ],
          ),
          title: const Text('Transactions App'),
        ),
        body: const TabBarView(
          children: [
            LogInView(),
            CreateAccountView(),
          ],
        ),
      ),
    ));
  }
}
