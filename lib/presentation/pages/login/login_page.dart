import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // para limitar caracteres
import '../dashboard/dashboard_page.dart'; // 🔑 Importar Dashboard

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction, // valida al interactuar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.school, size: 80, color: Color(0xFF1565C0)),
                const SizedBox(height: 16),
                const Text(
                  "Sist Control",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                const SizedBox(height: 32),

                // 📧 Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo institucional",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    final v = value.trim();
                    if (!v.contains('@') || !v.endsWith('.com')) {
                      return 'El correo debe contener @ y terminar en .com';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 🔑 Contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa la contraseña';
                    }
                    if (value.length < 8) {
                      return 'La contraseña debe tener al menos 8 caracteres';
                    }
                    if (value.length > 15) {
                      return 'La contraseña no puede tener más de 15 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 🚀 Botón de iniciar sesión
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // ✅ Navegar al Dashboard y reemplazar Login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardMobilePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Corrige los errores del formulario'),
                        ),
                      );
                    }
                  },
                  child: const Text("Iniciar Sesión"),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    // Aquí podrías navegar a una vista de recuperación de contraseña
                  },
                  child: const Text("¿Olvidaste tu contraseña?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
