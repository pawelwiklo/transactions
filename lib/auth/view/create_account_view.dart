import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/auth/utils/utils.dart';
import 'package:transactions/auth/widgets/widgets.dart';
import 'package:transactions/widgets.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

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
          const SizedBox(height: 8.0),
          TextFieldBuilder(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            onChanged: (value) => clearErrorMessage(context),
          ),
          const SizedBox(height: 8.0),
          TextFieldBuilder(
            controller: passwordRepeatController,
            hintText: 'Repeat Password',
            obscureText: true,
            onChanged: (value) => clearErrorMessage(context),
          ),
          const SizedBox(height: 8.0),
          StoreBuilder<AppState>(
            builder: (context, store) {
              return ElevatedButton(
                onPressed: () => handleCreateAccount(store),
                child: const Text('Create Account'),
              );
            },
          ),
          const SizedBox(height: 8.0),
          const ErrorMessageWidget(),
        ],
      ),
    );
  }

  void handleCreateAccount(Store<AppState> store) {
    String password = passwordController.text;
    String passwordRepeat = passwordRepeatController.text;

    String validationError = validatePasswords(password, passwordRepeat);

    if (validationError.isEmpty) {
      store.dispatch(CreateAccount(
        email: emailController.text,
        password: passwordController.text,
      ));
    } else {
      store.dispatch(AuthErrorAction(
        errorMessage: validationError,
        showErrorMessage: true,
      ));
    }
  }

  String validatePasswords(String password, String passwordRepeat) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (password != passwordRepeat) {
      return 'Passwords do not match';
    }
    return '';
  }
}
