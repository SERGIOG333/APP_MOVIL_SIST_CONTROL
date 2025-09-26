import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String id;
  final String email;
  final String time;
  //final String status;
  //final Color statusColor;
  //final IconData statusIcon;

  const StudentCard({
    super.key,
    required this.name,
    required this.id,
    required this.email,
    required this.time,
    //required this.status,
    //required this.statusColor,
    //required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black12,
            child: Icon(Icons.person, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text("T.I: $id", style: const TextStyle(fontSize: 12)),
                Text(email, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(6),
                    ),
                    
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}
