import 'package:flutter/material.dart';
import '../../widgets/student_card.dart';
import '../../widgets/summary_box.dart';
import '../../widgets/search_bar.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Lista de estudiante",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Resumen superior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SummaryBox(value: "8", label: "Total", color: Colors.black),
                SummaryBox(value: "2", label: "Presente", color: Colors.green),
                SummaryBox(value: "5", label: "Salido", color: Colors.orange),
                SummaryBox(value: "8", label: "Ausente", color: Colors.red),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Barra de búsqueda reutilizable
            SearchBarWidget(
              hintText: "Buscar por nombre o ID...",
              onChanged: (value) {
                // Aquí puedes implementar la lógica de búsqueda
                print("Buscando: $value");
              },
            ),

            const SizedBox(height: 16),

            // 🔹 Lista de estudiantes
            Column(
              children: const [
                StudentCard(
                  name: "Ana María García",
                  id: "1234567890",
                  email: "ana.madre@email.com",
                  time: "8:15:00 AM",
                  status: "PRESENTE",
                  statusColor: Colors.green,
                  statusIcon: Icons.check_circle,
                ),
                StudentCard(
                  name: "Ana María García",
                  id: "1234567890",
                  email: "ana.madre@email.com",
                  time: "8:15:00 AM",
                  status: "AUSENTE",
                  statusColor: Colors.red,
                  statusIcon: Icons.cancel,
                ),
                StudentCard(
                  name: "Ana María García",
                  id: "1234567890",
                  email: "ana.madre@email.com",
                  time: "8:15:00 AM",
                  status: "PRESENTE",
                  statusColor: Colors.green,
                  statusIcon: Icons.check_circle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
