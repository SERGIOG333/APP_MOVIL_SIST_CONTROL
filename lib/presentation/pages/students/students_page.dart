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
  late Future<List<dynamic>> _studentsFuture;
  List<dynamic> _allStudents = [];
  List<dynamic> _filteredStudents = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() {
    _studentsFuture = _studentService.getStudents();
    _studentsFuture.then((students) {
      setState(() {
        _allStudents = students;
        _filteredStudents = students;
      });
    });
  }

  void _filterStudents(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();

      if (_searchQuery.isEmpty) {
        _filteredStudents = _allStudents;
      } else {
        _filteredStudents = _allStudents.where((student) {
          final studentName = (student['student_name'] ?? "").toLowerCase();
          final studentLastName = (student['student_last_name'] ?? "")
              .toLowerCase();
          final fullName = "$studentName $studentLastName";
          final studentId = (student['student_identificacion'] ?? "")
              .toString()
              .toLowerCase();
          final studentEmail = (student['student_email'] ?? "").toLowerCase();

          return fullName.contains(_searchQuery) ||
              studentId.contains(_searchQuery) ||
              studentEmail.contains(_searchQuery);
        }).toList();
      }
    });
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
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay estudiantes"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SummaryBox(
                    value: "${_allStudents.length}",
                    label: "Total estudiantes",
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 16),

                SearchBarWidget(
                  hintText: "Buscar por nombre o ID...",
                  onChanged: _filterStudents,
                ),

                const SizedBox(height: 16),

                if (_filteredStudents.isEmpty && _searchQuery.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      "No se encontraron estudiantes",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                else
                  Column(
                    children: _filteredStudents.map((student) {
                      return StudentCard(
                        name:
                            "${student['student_name']} ${student['student_last_name']}",
                        id: student['student_identificacion'] ?? "N/A",
                        email: student['student_email'] ?? "Sin correo",
                        time: student['student_arrival_time'] ?? "Sin hora",
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
