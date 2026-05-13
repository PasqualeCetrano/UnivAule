import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_notifiche/view_model/schermata_notifiche_view_model.dart';


class NotificheScreen extends StatelessWidget {
  const NotificheScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificheViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('NOTIFICHE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16)
        ],
      ),
      // Se la lista è vuota, mostriamo un messaggio
      body: viewModel.notifiche.isEmpty
          ? const Center(child: Text("Non hai nuove notifiche.", style: TextStyle(color: Colors.grey, fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: viewModel.notifiche.length,
              itemBuilder: (context, index) {
                final notifica = viewModel.notifiche[index];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Messaggio Notifica
                        Text(
                          notifica.messaggio,
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),
                        
                        // 2. Pulsanti e Data/Ora
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icone Azione (Info e Cestino)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info_outline, color: Colors.blue, size: 22),
                                  tooltip: "Info Aula",
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.only(right: 12),
                                  onPressed: () {
                                    // Qui in futuro aprirai la schermata di Dettaglio dell'aula
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Apertura dettagli per: ${notifica.idAula}")),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                                  tooltip: "Elimina",
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () => viewModel.rimuoviNotifica(notifica.id),
                                ),
                              ],
                            ),
                            
                            // Badge grigio con Data e Ora (come da tuo mockup)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${notifica.data} • ${notifica.ora}",
                                style: const TextStyle(fontSize: 11, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}