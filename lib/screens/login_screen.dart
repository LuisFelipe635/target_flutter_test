import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? _validateUser(final String? user) {
    if (user != null) {
      return (user.isNotEmpty && user.length <= 20 && !user.endsWith(' '))
          ? null
          : 'Usuário inválido';
    }

    return 'Insira um usuário';
  }

  String? _validatePassword(final String? password) {
    final passwordRegex = RegExp(r'^([a-zA-Z0-9]{2,20})(?!\s)$');

    if (password != null) {
      return (passwordRegex.hasMatch(password)) ? null : 'Senha inválida';
    }

    return 'Insira uma senha';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF215366),
              Color(0xFF2D958E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Usuário',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            validator: _validateUser,
                            onEditingComplete: () => FocusScope.of(context).nextFocus(),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Senha',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            validator: _validatePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          ElevatedButton(
                            onPressed: () {
                              _formKey.currentState?.validate();
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
                            child: const Text('Entrar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => launchUrlString(
                    'https://www.google.com.br',
                    mode: LaunchMode.externalApplication,
                  ),
                  child: const Text(
                    'Política de Privacidade',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
