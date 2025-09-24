import 'package:flutter/material.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/teacher_card.dart';
import '../../../services/teacher_service.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  final TeacherService _teacherService = TeacherService();
  late Future<List<dynamic>> _teachersFuture;

  @override
  void initState() {
    super.initState();
    _teachersFuture = _teacherService.getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        title: const Text(
          "Lista de profesores",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
            const SearchBarWidget(hintText: "Buscar por nombre o ID..."),

            const SizedBox(height: 20),

            // 📋 Lista de profesores con FutureBuilder
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _teachersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No hay profesores disponibles"),
                    );
                  }

                  final teachers = snapshot.data!;

                  return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];
                      return TeacherCard(
                        name:
                            "${teacher['teacher_name']} ${teacher['teacher_last_name']}",
                        id: "ID: ${teacher['teacher_identificacion']}",
                        email: teacher['teacher_email'],
                        time: "8:15:00 AM", // Ajusta si tienes hora real
                        status: "PRESENTE", // Puedes calcular según tu lógica
                        statusColor: Colors.green,
                        statusIcon: Icons.check_circle,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
