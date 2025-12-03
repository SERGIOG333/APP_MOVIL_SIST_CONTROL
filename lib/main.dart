import 'package:flutter/material.dart';
import 'presentation/pages/login/login_page.dart';
import 'core/theme/app_theme.dart'; //  Importa el tema global

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sist Control',
      theme: AppTheme.lightTheme, //  Aplica el tema global
      home: const LoginPage(), //  Pantalla inicial
    );
  }
}
