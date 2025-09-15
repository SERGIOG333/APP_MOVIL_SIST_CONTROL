import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Cursos"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: const Center(
        child: Text(
          "Página con la lista de cursos",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
