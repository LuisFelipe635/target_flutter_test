import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';

import '../shared/app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final AppStrings _strings;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _strings = AppStrings.of(context);
  }

  String? _validateUser(final String? user) {
    if (user != null) {
      return (user.isNotEmpty && user.length <= 20 && !user.endsWith(' ')) ? null : _strings.invalidUser;
    }

    return _strings.blankUser;
  }

  String? _validatePassword(final String? password) {
    final passwordRegex = RegExp(r'^([a-zA-Z0-9]{2,20})(?!\s)$');

    if (password != null) {
      return (passwordRegex.hasMatch(password)) ? null : _strings.invalidPassword;
    }

    return _strings.blankPassword;
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
            _createTextFieldLabel(_strings.user),
            const SizedBox(height: 8.0),
            TextFormField(
              validator: _validateUser,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: _createInputDecoration(withIcon: Icons.person),
            ),
            const SizedBox(height: 16.0),
            _createTextFieldLabel(_strings.password),
            const SizedBox(height: 8.0),
            TextFormField(
              validator: _validatePassword,
              obscureText: true,
              decoration: _createInputDecoration(withIcon: Icons.lock),
            ),
            const SizedBox(height: 32.0),
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
                  Size(MediaQuery.of(context).size.width * 0.35, 40.0),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.0),
                  ),
                ),
              ),
              child: Text(_strings.logIn),
            ),
          ],
        ),
      ),
    );
  }
}
