import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Generar Código QR",
          style: TextStyle(
            color: Colors.black, //
            fontWeight: FontWeight.bold,

            // 🔹 Usamos el color del tema
          ),
        ),
      ),
      body: Align(
        alignment: const Alignment(
          0,
          -0.7,
        ), // x=0 centro horizontal, y=-0.5 hacia arriba
        child: Container(
          width: 350,
          height: 500,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardColor, // 🔹 Fondo blanco
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
                "Informacion del Estudiante",
                style: TextStyle(fontSize: 11, color: Colors.black),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),

              const Text(
                "Completa todos los Campos para Generar el Codigo QR",
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              const Text(
                "Nombre del Estudiante",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Caja de texto
              TextField(
                
                decoration: InputDecoration(
                  
                  hintText: "Ingresa el nombre",
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Numero de Identidad",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Caja de texto
              TextField(
                
                decoration: InputDecoration(
                  
                  hintText: "Ingresa el numero de identidad",
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Grado",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Caja de texto
              TextField(
                
                decoration: InputDecoration(
                  
                  hintText: "Ingresa el grado",
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Email del padre/madre",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Caja de texto
              TextField(
                
                decoration: InputDecoration(
                  
                  hintText: "Ingresa el Email",
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

    // Botón del mismo ancho
    SizedBox(
      width: double.infinity, // Ocupa todo el ancho disponible del container
      height: 50, // altura del botón
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // color azul del tema
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Mostrar alerta
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Éxito"),
                content: const Text("QR creado con éxito"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // cerrar la alerta
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(
          "Generar QR",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
            ],
          ),
        ),
      ),
    );
  }
}
