import 'package:flutter/material.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Estudiantes"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: const Center(
        child: Text(
          "Página con la lista de estudiantes",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
