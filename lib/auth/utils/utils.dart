import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';

void clearErrorMessage(BuildContext context) {
  final store = StoreProvider.of<AppState>(context);
  if (store.state.showErrorMessage) {
    store.dispatch(AuthErrorAction(
      errorMessage: '',
      showErrorMessage: false,
    ));
  }
}
