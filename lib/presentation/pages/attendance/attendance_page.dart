import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String? qrText;
  final MobileScannerController cameraController = MobileScannerController();

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                    const Text(
                      "Cámara Escáner",
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Posiciona el código QR del estudiante frente a la cámara",
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(height: 16),

                    // 📷 Escáner con MobileScanner
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MobileScanner(
                          controller: cameraController,
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            for (final barcode in barcodes) {
                              setState(() {
                                qrText =
                                    barcode.rawValue ?? "Código no reconocido";
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 📌 Resultado dentro del primer container
                    Center(
                      child: Text(
                        qrText ?? "Esperando lectura...",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔄 Botón para reintentar
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          cameraController.start();
                        },
                        child: const Text(
                          "Iniciar Escanear",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Segundo container debajo con instrucciones fijas
            Container(
              width: 350,
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                children: const [
                  Text(
                    "Instrucciones de Uso",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text("- Presiona 'Iniciar Escanear' para activar la cámara",
                      style: TextStyle(fontSize: 11)),
                  SizedBox(height: 10),
                  Text("- Posiciona el código QR frente a la cámara para registrar la asistencia",
                      style: TextStyle(fontSize: 11)),
                  SizedBox(height: 10),
                  Text("- El sistema detectará automáticamente el código",
                      style: TextStyle(fontSize: 11)),
                  SizedBox(height: 10),
                  Text("- Se envía un email inmediato a los padres",
                      style: TextStyle(fontSize: 11)),
                  SizedBox(height: 10),
                  Text("- El registro quedará guardado en el historial",
                      style: TextStyle(fontSize: 11)),
                ],
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
