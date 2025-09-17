import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/labeled_text_field.dart';

class GenerateQrPage extends StatefulWidget {
  const GenerateQrPage({super.key});

  @override
  State<GenerateQrPage> createState() => _GenerateQrPageState();
}

class _GenerateQrPageState extends State<GenerateQrPage> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _gradeController = TextEditingController();
  final _emailController = TextEditingController();

  String? qrData; // Contenido del QR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Generar Código QR",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: const Alignment(0, -0.7),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Información del Estudiante",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Completa todos los Campos para Generar el Código QR",
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 16),

                // Campos reutilizando el widget
                LabeledTextField(
                  label: "Nombre del Estudiante",
                  hint: "Ingresa el nombre",
                  controller: _nameController,
                ),
                LabeledTextField(
                  label: "Número de Identidad",
                  hint: "Ingresa el número de identidad",
                  controller: _idController,
                ),
                LabeledTextField(
                  label: "Grado",
                  hint: "Ingresa el grado",
                  controller: _gradeController,
                ),
                LabeledTextField(
                  label: "Email del padre/madre",
                  hint: "Ingresa el email",
                  controller: _emailController,
                ),

                const SizedBox(height: 20),

                // Botón generar QR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        qrData =
                            "Nombre: ${_nameController.text}\n"
                            "ID: ${_idController.text}\n"
                            "Grado: ${_gradeController.text}\n"
                            "Email: ${_emailController.text}";
                      });
                    },
                    child: const Text(
                      "Generar QR",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Mostrar QR si ya fue generado
                if (qrData != null)
                  Center(
                    child: QrImageView(
                      data: qrData!,
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
