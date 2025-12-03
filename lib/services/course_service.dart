import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseService {
  final String baseUrl = "http://10.0.2.2:3000/api_v1";

  Future<List<dynamic>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/course'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception("Error al cargar cursos: ${response.statusCode}");
    }
  }

  Future<dynamic> getCourseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/course/$id'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception("Error al cargar curso: ${response.statusCode}");
    }
  }
}
