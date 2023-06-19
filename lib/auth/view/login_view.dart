import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/auth/utils/utils.dart';
import 'package:transactions/auth/widgets/widgets.dart';
import 'package:transactions/widgets.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFieldBuilder(
            controller: emailController,
            hintText: 'Email',
            onChanged: (value) => clearErrorMessage(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFieldBuilder(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            onChanged: (value) => clearErrorMessage(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          StoreConnector<AppState, void Function()>(
            converter: (store) => () => store.dispatch(LogInAction(
                email: emailController.text,
                password: passwordController.text)),
            builder: (_, callback) {
              return ElevatedButton(
                onPressed: callback,
                child: const Text('Log In'),
              );
            },
          ),
          const SizedBox(height: 8.0),
          const ErrorMessageWidget(),
        ],
      ),
    );
  }
}
