import 'package:flutter/material.dart';
import '../courses/courses_page.dart';
import '../students/students_page.dart';
import '../teachers/teachers_page.dart';
import '../attendance/attendance_page.dart';
import '../generate_qr/generate_qr_page.dart';
import '../login/login_page.dart';
import '../../../services/student_service.dart';

class DashboardMobilePage extends StatefulWidget {
  const DashboardMobilePage({super.key});

  @override
  State<DashboardMobilePage> createState() => _DashboardMobilePageState();
}

class _DashboardMobilePageState extends State<DashboardMobilePage> {
  int totalStudents = 0;
  int presentStudents = 0;
  int totalRegisters = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      // 👉 Traer estudiantes desde el servicio
      final students = await StudentService().getStudents();
      totalStudents = students.length;

      // 👉 Calcular presentes de hoy (arrivalTime que empiece con la fecha actual)
      final today = DateTime.now().toIso8601String().substring(0, 10);
      presentStudents = students.where((s) {
        final arrival = s['student_arrival_time'];
        return arrival != null && arrival.toString().startsWith(today);
      }).length;

      // 👉 Total registros de hoy (ejemplo simple = presentes)
      totalRegisters = presentStudents;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("❌ Error cargando dashboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📌 Encabezado
                    _buildHeader(context),
                    const SizedBox(height: 16),

                    // 📌 Tarjetas resumen
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: "Presentes de Hoy",
                            value: "$presentStudents",
                            subtitle: "de $totalStudents estudiantes",
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            title: "Registros Hoy",
                            value: "$totalRegisters",
                            subtitle: "entradas y salidas",
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      "Acciones principales",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    _buildActionTile(
                      icon: Icons.qr_code,
                      label: "Generar QR Estudiante",
                      subtitle: "Crear código QR único para estudiantes",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const GenerateQrPage()),
                        );
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.qr_code_scanner,
                      label: "Escanear QR",
                      subtitle: "Registrar entrada/salida de estudiantes",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AttendancePage()),
                        );
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.people,
                      label: "Lista de Estudiantes",
                      subtitle: "Ver estado actual de los inscritos",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StudentsPage()),
                        );
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.book,
                      label: "Lista de cursos",
                      subtitle: "Ver estado de los cursos",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CoursesPage()),
                        );
                      },
                    ),
                    _buildActionTile(
                      icon: Icons.person,
                      label: "Lista de profesores",
                      subtitle: "Ver docentes registrados",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TeachersPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // 📌 Encabezado
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Panel de control",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Colegio San José - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout, size: 28, color: Colors.black),
            tooltip: "Cerrar sesión",
          ),
        ],
      ),
    );
  }

  // 📌 Tarjeta de estadísticas
  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // 📌 Botón de acción
  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
