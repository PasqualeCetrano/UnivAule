import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>(); // ViewModel

    return Scaffold(
      body: Column(
        children: [
          // Header Giallo
          Container(
            width: double.infinity,
            height: 180,
            color: const Color(0xFFFFEB3B), // Giallo acceso
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              "Il tuo ruolo:",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40), 
          _buildRoleCard( // Pulsante Studente
            context, 
            "STUDENTE", 
            Icons.person_outline, 
            Colors.red, 
            () => viewModel.selezionaRuolo(context, 'STUDENTE')
          ),
          const SizedBox(height: 20), 
          _buildRoleCard( // Pulsante Docente
            context,  
            "DOCENTE", 
            Icons.edit_note, 
            Colors.deepPurple, 
            () => viewModel.selezionaRuolo(context, 'DOCENTE')
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ],
          ),
        ),
      ),
    );
  }
}