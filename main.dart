import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importe sua tela de login
import 'registration_screen.dart'; // Importe sua tela de cadastro

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Avaliação de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Define a tela de login como a tela inicial
      routes: {
        // Defina as rotas para navegação nomeada, se desejar
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
      },
    );
  }
}
