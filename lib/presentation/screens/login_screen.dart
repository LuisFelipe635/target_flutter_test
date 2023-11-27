import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';

import '../shared/app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _maxUserLength = 20;
  static const _smallVerticalSpace = 8.0;
  static const _mediumVerticalSpace = 16.0;
  static const _bigVerticalSpace = 32.0;
  static const _buttonWidthFactor = 0.35;
  static const _buttonHeight = 40.0;
  static const _buttonBorderRadius = BorderRadius.all(Radius.circular(48.0));

  final GlobalKey<FormState> _formKey = GlobalKey();
  AppStrings? _strings;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _strings ??= AppStrings.of(context);
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  String? _validateUser(final String? user) {
    if (user == null || user.isEmpty) {
      return _strings?.blankUser;
    }

    return (user.length <= _maxUserLength && !user.endsWith(' ')) ? null : _strings?.invalidUser;
  }

  String? _validatePassword(final String? password) {
    // This regex matches any string between 2 and 20 characters long, containing only alphanumeric
    // characters, and not ended with whitespace
    final passwordRegex = RegExp(r'^([a-zA-Z0-9]{2,20})(?!\s)$');

    if (password == null || password.isEmpty) {
      return _strings?.blankPassword;
    }

    return (passwordRegex.hasMatch(password)) ? null : _strings?.invalidPassword;
  }

  Widget _createTextFieldLabel(final String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  InputDecoration _createInputDecoration({required final IconData withIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(),
      prefixIcon: Icon(withIcon, color: Colors.black),
      errorStyle: const TextStyle(color: Colors.orangeAccent),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
      focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _createTextFieldLabel(_strings?.user ?? ''),
            const SizedBox(height: _smallVerticalSpace),
            TextFormField(
              validator: _validateUser,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: _createInputDecoration(withIcon: Icons.person),
            ),
            const SizedBox(height: _mediumVerticalSpace),
            _createTextFieldLabel(_strings?.password ?? ''),
            const SizedBox(height: _smallVerticalSpace),
            TextFormField(
              validator: _validatePassword,
              obscureText: true,
              decoration: _createInputDecoration(withIcon: Icons.lock),
            ),
            const SizedBox(height: _bigVerticalSpace),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();

                if (isValid) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Color(0xFF44BD6E)),
                fixedSize: MaterialStatePropertyAll(
                  Size(MediaQuery.of(context).size.width * _buttonWidthFactor, _buttonHeight),
                ),
                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: _buttonBorderRadius)),
              ),
              child: Text(_strings?.logIn ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
