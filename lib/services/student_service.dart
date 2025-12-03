import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class StudentService {
  final String baseUrl = "http://10.0.2.2:3000/api_v1";

  Future<List<dynamic>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/student'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception("Error al cargar estudiantes: ${response.statusCode}");
    }
  }

  Future<Uint8List?> getQrByIdentification(String identification) async {
    final response = await http.get(
      Uri.parse('$baseUrl/student/$identification/qr'),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }

    return null;
  }
}
