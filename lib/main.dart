import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';

import 'configuration/application_composition_root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appCompositionRoot = ApplicationCompositionRoot.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Target Test',
      home: appCompositionRoot.newLoginScreen(),
      routes: {
        '/home': (final context) => appCompositionRoot.newMainScreen(),
      },
      localizationsDelegates: AppStrings.localizationsDelegates,
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
      ],
    );
  }
}
