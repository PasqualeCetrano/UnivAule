import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/area_docente_view_model.dart';

class AreaDocenteScreen extends StatelessWidget {
  const AreaDocenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AreaDocenteViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 6, width: double.infinity, color: const Color(0xFFFFEB3B)),
            
            // intestazione con saluto 
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
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
                  const SizedBox(height: 6),
                  const Text(
                    "Bentornato nel tuo pannello di gestione.",
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            
            // lista dei bottoni del menu principale
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  // Vai alla Ricerca Aule (schermata_prenotazione)
                  _buildMenuButton(
                    label: "PRENOTA UN'AULA",
                    icon: Icons.calendar_today_outlined,
                    iconColor: Colors.green,
                    onTap: () => viewModel.vaiAPrenotazione(context),
                  ),
                  //  Vai a Le Tue Prenotazioni (mie_prenotazioni)
                  _buildMenuButton(
                    label: "LE TUE PRENOTAZIONI",
                    icon: Icons.edit_note,
                    iconColor: Colors.orange,
                    onTap: () => viewModel.vaiALeTuePrenotazioni(context),
                  ),
                  //  Vai a Segnala Problema (schermata_segnalazioni)
                  _buildMenuButton(
                    label: "SEGNALA PROBLEMA",
                    icon: Icons.error_outline,
                    iconColor: Colors.yellow[800]!,
                    onTap: () => viewModel.vaiASegnalaProblema(context),
                  ),
                  //  Vai a Notifiche (schermata_notifiche)
                  _buildMenuButton(
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
      ),
    );
  }

  // --- WIDGET HELPER PER I BOTTONI ---
  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}