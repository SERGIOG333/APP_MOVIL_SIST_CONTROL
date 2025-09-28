import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:3000/api_v1"; // tu backend en emulador Android

  // --- Método privado para imprimir token ---
  Future<void> _checkToken() async {
    final token = await TokenStorage.getToken();
    print("🔑 TOKEN GUARDADO: $token");
  }

  // --- LOGIN ADMIN ---
  Future<Map<String, dynamic>> loginAdmin(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "admin_email": email,
        "admin_password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Guardar token
      await TokenStorage.saveToken(data["token"]);
      await _checkToken(); // imprimir token en consola

      return data;
    } else {
      throw Exception("Error de login admin: ${response.body}");
    }
  }

  // --- LOGIN USUARIO ---
  Future<Map<String, dynamic>> loginUser(String usuario, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Users_usuario": usuario,
        "Users_password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Guardar token
      await TokenStorage.saveToken(data["token"]);
      await _checkToken(); // imprimir token en consola

      return data;
    } else {
      throw Exception("Error de login usuario: ${response.body}");
    }
  }
}
