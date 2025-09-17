import 'package:flutter/material.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/teacher_card.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        title: const Text(
          "Lista de profesores",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Estado actual de todos los profesores",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📊 Resumen de profesores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SummaryBox(value: "8", label: "Total", color: Colors.black),
                SummaryBox(value: "2", label: "Presente", color: Colors.green),
                SummaryBox(value: "5", label: "Salido", color: Colors.orange),
                SummaryBox(value: "8", label: "Ausente", color: Colors.red),
              ],
            ),

            const SizedBox(height: 16),

            // 🔍 Barra de búsqueda
            const SearchBarWidget(
              hintText: "Buscar por nombre o ID...",
            ),

            const SizedBox(height: 20),

            // 📋 Lista de profesores
            Expanded(
              child: ListView(
                children: const [
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "PRESENTE",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "PRESENTE",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "PRESENTE",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "AUSENTE",
                    statusColor: Colors.red,
                    statusIcon: Icons.cancel,
                  ),
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "PRESENTE",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  TeacherCard(
                    name: "Ana María García",
                    id: "11A. ID: 1234567890",
                    email: "ana.madre@gmail.com",
                    time: "8:15:00 AM",
                    status: "PRESENTE",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
