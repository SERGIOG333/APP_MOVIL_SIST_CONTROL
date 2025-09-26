import 'package:flutter/material.dart';
import '../../widgets/student_card.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';
import '../../../services/student_service.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final StudentService _studentService = StudentService();
  late Future<List<dynamic>> students;

  @override
  void initState() {
    super.initState();
    students = _studentService.getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Lista de estudiante",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay estudiantes"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
              width: double.infinity,
              child:  SummaryBox(
                value: "${data.length}",
                label: "Total estudiantes",
                color: Colors.green,
              ),
            ),
                // 
                //🔹 Resumen superior (ejemplo básico)
                

                const SizedBox(height: 16),

                // 🔹 Barra de búsqueda
                SearchBarWidget(
                  hintText: "Buscar por nombre o ID...",
                  onChanged: (value) {
                    print("Buscando: $value");
                  },
                ),

                const SizedBox(height: 16),

                // 🔹 Lista de estudiantes desde API
                Column(
                  children: data.map((student) {
                    return StudentCard(
                      name:
                          "${student['student_name']} ${student['student_last_name']}",
                      id: student['student_identificacion'] ?? "N/A",
                      email: student['student_email'] ?? "Sin correo",
                      time: student['student_arrival_time'] ?? "Sin hora",
                      //status: "AUSENTE", // luego lo puedes mapear
                      //statusColor: Colors.red,
                      //statusIcon: Icons.cancel,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
