import 'package:appwrite/models.dart';
import 'package:transactions/models/transaction.dart';

abstract class AppState {
  String? get errorMessage;
  bool get showErrorMessage;
  Session? get session;
  String? get userEmail;
  List<Transaction>? get data; // Add the data property
  AppState copyWith({
    String? errorMessage,
    bool? showErrorMessage,
    Session? session,
    String? userEmail,
    List<Transaction>? data, // Include the data property in the copyWith method
  });
}

class AppUnauthenticated implements AppState {
  final String? errorMessage;
  final bool showErrorMessage;
  final Session? session;
  final String? userEmail;
  final List<Transaction>? data; // Add the data property

  AppUnauthenticated({
    this.errorMessage,
    this.showErrorMessage = false,
    this.session,
    this.userEmail,
    this.data, // Include the data property in the constructor
  });

  @override
  AppUnauthenticated copyWith({
    String? errorMessage,
    bool? showErrorMessage,
    Session? session,
    String? userEmail,
    List<Transaction>? data, // Include the data property in the copyWith method
  }) {
    return AppUnauthenticated(
      errorMessage: errorMessage ?? this.errorMessage,
      showErrorMessage: showErrorMessage ?? this.showErrorMessage,
      session: session ?? this.session,
      userEmail: userEmail ?? this.userEmail,
      data: data ?? this.data, // Update the copyWith method
    );
  }
}
