import 'package:flutter/material.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generar QR"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: const Center(
        child: Text(
          "Página para generar QR de estudiantes",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
