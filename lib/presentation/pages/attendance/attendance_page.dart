import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanear QR - Asistencia"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: const Center(
        child: Text(
          "Página para escanear QR y registrar asistencia",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
