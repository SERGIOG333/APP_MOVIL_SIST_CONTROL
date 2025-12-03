import 'package:flutter/material.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/course_card.dart';
import '../../../services/course_service.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final CourseService _courseService = CourseService();
  late Future<List<dynamic>> _coursesFuture;
  List<dynamic> _allCourses = [];
  List<dynamic> _filteredCourses = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    _coursesFuture = _courseService.getCourses();
    _coursesFuture.then((courses) {
      setState(() {
        _allCourses = courses;
        _filteredCourses = courses;
      });
    });
  }

  void _filterCourses(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      
      if (_searchQuery.isEmpty) {
        _filteredCourses = _allCourses;
      } else {
        _filteredCourses = _allCourses.where((course) {
          final courseName = (course['course_course_name'] ?? "").toLowerCase();
          final courseId = course['course_id'].toString().toLowerCase();
          
          return courseName.contains(_searchQuery) || courseId.contains(_searchQuery);
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
          "Lista de cursos",
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
              "Estado actual de todos los cursos",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _coursesFuture,
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
                child: Text("No hay cursos disponibles"),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SummaryBox(
                    value: "${_allCourses.length}",
                    label: "Total Cursos",
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 16),

                SearchBarWidget(
                  hintText: "Buscar por nombre o ID curso...",
                  onChanged: _filterCourses,
                ),

                const SizedBox(height: 20),

                if (_filteredCourses.isEmpty && _searchQuery.isNotEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No se encontraron cursos",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCourses.length,
                      itemBuilder: (context, index) {
                        final course = _filteredCourses[index];
                        return CourseCard(
                          name: course['course_course_name'] ?? "",
                          id: "ID: ${course['course_id']}",
                          teacher: "Profesor Asignado: ${course['teacher_fk'] ?? "Sin asignar"}",
                          time: "8:15:00 AM",
                          status: "ACTIVO",
                          statusColor: Colors.green,
                          statusIcon: Icons.check_circle,
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