import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Target Test',
      home: const LoginScreen(),
      routes: {
        '/home': (final context) => const HomeScreen(),
      },
    );
  }
}
