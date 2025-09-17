import 'package:flutter/material.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/course_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        title: const Text(
          "Lista de cursos",
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
              "Estado actual de todos los cursos",
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
            // 👉 SummaryBox ahora ocupa todo el ancho
            SizedBox(
              width: double.infinity,
              child: const SummaryBox(
                value: "8",
                label: "Total Cursos",
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 16),

            const SearchBarWidget(
              hintText: "Buscar por nombre o ID curso...",
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  CourseCard(
                    name: "Matemáticas",
                    id: "11A. ID: 1234567890",
                    teacher: "Profesor Asignado: Pedro",
                    time: "8:15:00 AM",
                    status: "ACTIVO",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  CourseCard(
                    name: "Sociales",
                    id: "11A. ID: 1234567890",
                    teacher: "",
                    time: "8:15:00 AM",
                    status: "ACTIVO",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  CourseCard(
                    name: "Química",
                    id: "11A. ID: 1234567890",
                    teacher: "",
                    time: "8:15:00 AM",
                    status: "ACTIVO",
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                  ),
                  CourseCard(
                    name: "Física",
                    id: "11A. ID: 1234567890",
                    teacher: "",
                    time: "8:15:00 AM",
                    status: "DESACTIVO",
                    statusColor: Colors.red,
                    statusIcon: Icons.cancel,
                  ),
                  CourseCard(
                    name: "Biología",
                    id: "11A. ID: 1234567890",
                    teacher: "",
                    time: "8:15:00 AM",
                    status: "ACTIVO",
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
