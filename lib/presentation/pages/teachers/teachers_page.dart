import 'package:flutter/material.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Profesores"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: const Center(
        child: Text(
          "Página con la lista de profesores",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
