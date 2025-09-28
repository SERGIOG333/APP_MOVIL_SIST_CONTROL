import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../../../services/token_storage.dart';
import '../dashboard/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Método para imprimir el token guardado
  Future<void> _checkToken() async {
    final token = await TokenStorage.getToken();
    print("🔑 TOKEN GUARDADO: $token");
  }

  Future<void> _loginAdmin() async {
    try {
      final result = await _authService.loginAdmin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Guardamos el token en almacenamiento local
      await TokenStorage.saveToken(result['token']);

      // Imprimimos el token guardado
      await _checkToken();

      // Si llega aquí, login exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bienvenido Admin")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardMobilePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _loginUser() async {
    try {
      final result = await _authService.loginUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Guardamos el token en almacenamiento local
      await TokenStorage.saveToken(result['token']);

      // Imprimimos el token guardado
      await _checkToken();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bienvenido Usuario")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardMobilePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset('assets/icon/icono_sist_control.png', height: 80, width: 80),
              const SizedBox(height: 16),
              const Text(
                "Sist Control",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Correo o Usuario",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botón Admin
              ElevatedButton(
                onPressed: _loginAdmin,
                child: const Text("Iniciar como Admin"),
              ),
              const SizedBox(height: 12),

              // Botón Usuario
              ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Iniciar como Usuario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
