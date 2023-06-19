import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/auth/constants.dart';

class TextFieldBuilder extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const TextFieldBuilder({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          textAlign: TextAlign.center,
          decoration: kTextFieldDecoration.copyWith(hintText: hintText),
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.userEmail ?? '',
      builder: (context, userEmail) {
        return AppBar(
          title: Text('Hi $userEmail!'),
        );
      },
    );
  }
}
