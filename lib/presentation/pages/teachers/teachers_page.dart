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
  List<dynamic> _allTeachers = [];
  List<dynamic> _filteredTeachers = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  void _loadTeachers() {
    _teachersFuture = _teacherService.getTeachers();
    _teachersFuture.then((teachers) {
      setState(() {
        _allTeachers = teachers;
        _filteredTeachers = teachers;
      });
    });
  }

  void _filterTeachers(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();

      if (_searchQuery.isEmpty) {
        _filteredTeachers = _allTeachers;
      } else {
        _filteredTeachers = _allTeachers.where((teacher) {
          final teacherName = (teacher['teacher_name'] ?? "").toLowerCase();
          final teacherLastName = (teacher['teacher_last_name'] ?? "")
              .toLowerCase();
          final fullName = "$teacherName $teacherLastName";
          final teacherId = (teacher['teacher_identificacion'] ?? "")
              .toString()
              .toLowerCase();
          final teacherEmail = (teacher['teacher_email'] ?? "").toLowerCase();

          return fullName.contains(_searchQuery) ||
              teacherId.contains(_searchQuery) ||
              teacherEmail.contains(_searchQuery);
        }).toList();
      }
    });
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
              return const Center(child: Text("No hay profesores disponibles"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SummaryBox(
                    value: "${_allTeachers.length}",
                    label: "Total Profesores",
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 16),

                SearchBarWidget(
                  hintText: "Buscar por nombre o ID profesor...",
                  onChanged: _filterTeachers,
                ),

                const SizedBox(height: 20),

                if (_filteredTeachers.isEmpty && _searchQuery.isNotEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No se encontraron profesores",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredTeachers.length,
                      itemBuilder: (context, index) {
                        final teacher = _filteredTeachers[index];
                        return TeacherCard(
                          name:
                              "${teacher['teacher_name']} ${teacher['teacher_last_name']}",
                          id: "ID: ${teacher['teacher_identificacion']}",
                          email: teacher['teacher_email'],
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
