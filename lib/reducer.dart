import 'actions.dart';
import 'app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is AuthErrorAction) {
    return state.copyWith(
        errorMessage: action.errorMessage,
        showErrorMessage: action.showErrorMessage);
  } else if (action is DataFetchedAction) {
    return state.copyWith(data: action.data);
  } else if (action is TransactionsListUpdated) {
    return state.copyWith(data: action.transactions);
  } else if (action is CreateUserSession) {
    return state.copyWith(session: action.session, userEmail: action.userEmail);
  } else {
    return state;
  }
}
