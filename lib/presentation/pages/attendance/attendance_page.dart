import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/theme/app_theme.dart';
import '../../../services/attendance_service.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String? qrText;
  final MobileScannerController cameraController = MobileScannerController();
  final AttendanceService _attendanceService = AttendanceService();
  bool _isProcessing = false;

  /// 🔹 Tipo de acción seleccionada (entrada/salida)
  String _actionType = "entrada";

  Future<void> _handleAttendance(String scannedCode) async {
    if (_isProcessing) return; // Evita múltiples lecturas
    setState(() => _isProcessing = true);

    try {
      // 🔹 Parseamos el JSON que viene en el QR
      final decoded = jsonDecode(scannedCode);
      final studentId = decoded["student_id"];
      final studentName = decoded["nombre"];
      final studentIdent = decoded["identificacion"];

      if (studentId == null) {
        throw Exception("QR inválido: no contiene student_id");
      }

      Map<String, dynamic> result;

      if (_actionType == "entrada") {
        result = await _attendanceService.registerAttendance(studentId);
      } else {
        result = await _attendanceService.registerExit(studentId);
      }

      // ✅ Mensaje limpio del backend
      final backendMessage = result["message"] ?? "Registro exitoso";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _actionType == "entrada" ? Colors.blue : Colors.red,
          content: Text(
            "✅ $backendMessage para $studentName ($studentIdent)",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

      setState(() {
        qrText =
            "✅ $studentName ($studentIdent)\n${_actionType.toUpperCase()} registrada";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "❌ Error al registrar asistencia.\nIntenta nuevamente.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Escanear Código QR",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Botones para elegir entrada o salida
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _actionType == "entrada"
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _actionType = "entrada");
                    },
                    label: const Text("Entrada"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _actionType == "salida"
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _actionType = "salida");
                    },
                    label: const Text("Salida"),
                  ),
                ],
              ),
            ),

            Align(
              alignment: const Alignment(0, -0.8),
              child: Container(
                width: 350,
                height: 490,
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
                    const Text("Cámara Escáner",
                        style: TextStyle(fontSize: 11, color: Colors.black)),
                    const SizedBox(height: 8),
                    const Text(
                      "Posiciona el código QR del estudiante frente a la cámara",
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MobileScanner(
                          controller: cameraController,
                          onDetect: (capture) {
                            for (final barcode in capture.barcodes) {
                              final code = barcode.rawValue;
                              if (code != null) {
                                _handleAttendance(code); // 🔹 Entrada/salida
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: Text(
                        qrText ?? "Esperando lectura...",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
