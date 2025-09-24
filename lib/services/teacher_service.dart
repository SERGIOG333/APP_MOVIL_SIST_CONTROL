import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherService {
  final String baseUrl =
      "http://10.0.2.2:3000/api_v1"; // cambia según tu entorno

  Future<List<dynamic>> getTeachers() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data']; // retornamos la lista de profesores
    } else {
      throw Exception("Error al cargar profesores: ${response.statusCode}");
    }
  }
}
