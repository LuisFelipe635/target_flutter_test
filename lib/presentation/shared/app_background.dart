import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required final Widget child,
  }) : _child = child;

  final Widget _child;

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
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Center(
                    child: _child,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => launchUrlString(
                    'https://www.google.com.br',
                    mode: LaunchMode.externalApplication,
                  ),
                  child: Text(
                    AppStrings.of(context).privacyPolicy,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
