import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage.dart';

class AttendanceService {
  final String baseUrl = "http://10.0.2.2:3000/api_v1";
  // Obtener todas las asistencias
  
  Future<List<dynamic>> getAllAttendances() async {
    final response = await http.get(Uri.parse('$baseUrl/attendance/'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception("Error al cargar asistencias: ${response.statusCode}");
    }
  } // Backend en emulador Android

  /// Registrar asistencia de entrada
  Future<Map<String, dynamic>> registerAttendance(int studentId) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/attendance"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"student_fk": studentId}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data; // ✅ Acepta 200, 201, 204...
    } else {
      throw Exception(data["message"] ?? "Error al registrar asistencia");
    }
  }

  /// Registrar salida
  Future<Map<String, dynamic>> registerExit(int studentId) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/exit"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"student_fk": studentId}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data; // ✅ Acepta 200, 201, 204...
    } else {
      throw Exception(data["message"] ?? "Error al registrar salida");
    }
  }
}
