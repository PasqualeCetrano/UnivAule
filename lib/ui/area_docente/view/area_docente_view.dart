import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/area_docente_view_model.dart';

class AreaDocenteScreen extends StatelessWidget {
  const AreaDocenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ascoltiamo il ViewModel per gestire la logica di navigazione
    final viewModel = context.watch<AreaDocenteViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Linea Gialla Superiore (Brand Identity UnivAule)
          Container(
            height: 10, 
            width: double.infinity,
            color: const Color(0xFFFFEB3B)
          ),
          
          // 2. Sezione Saluto Personalizzato
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ciao, Prof. Stefano Smriglio",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Cosa desidera fare?",
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          
          // 3. Lista dei 4 Bottoni Principali
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildDashboardButton(
                  label: "PRENOTA UN'AULA",
                  icon: Icons.calendar_today_outlined,
                  iconColor: Colors.green,
                  onTap: () => viewModel.vaiAPrenotazione(context),
                ),
                _buildDashboardButton(
                  label: "LE TUE PRENOTAZIONI",
                  icon: Icons.edit_note,
                  iconColor: Colors.orange,
                  onTap: () => viewModel.vaiALeTuePrenotazioni(context),
                ),
                _buildDashboardButton(
                  label: "SEGNALA PROBLEMA",
                  icon: Icons.error_outline,
                  iconColor: Colors.yellow[700]!,
                  onTap: () => viewModel.vaiASegnalaProblema(context),
                ),
                _buildDashboardButton(
                  label: "NOTIFICHE",
                  icon: Icons.notifications_none,
                  iconColor: Colors.red,
                  onTap: () => viewModel.vaiANotifiche(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper per creare i bottoni della dashboard
  Widget _buildDashboardButton({
    required String label,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), 
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 30),
              const SizedBox(width: 25),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}