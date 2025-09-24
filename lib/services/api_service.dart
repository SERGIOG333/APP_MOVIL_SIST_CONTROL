import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "http://192.168.1.10:3000/api_v1"; // cambia por tu IP o dominio

  // Ejemplo: obtener todos los estudiantes
  Future<List<dynamic>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/student'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al cargar estudiantes");
    }
  }
}
