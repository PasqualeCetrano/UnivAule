import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_notifiche/view_model/schermata_notifiche_view_model.dart';

class NotificheScreen extends StatelessWidget {
  const NotificheScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificheViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('NOTIFICHE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        centerTitle: true,
      ),
      body: viewModel.notifiche.isEmpty // se non ci sono notifiche
          ? const Center(
              child: Text(
                "Non ci sono nuove notifiche", 
                style: TextStyle(color: Colors.grey, fontSize: 16)
              )
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.notifiche.length,
              itemBuilder: (context, index) {
                final notifica = viewModel.notifiche[index];
                return _buildNotificaCard(context, viewModel, notifica);
              },
            ),
    );
  }
  // widget helper
  Widget _buildNotificaCard(BuildContext context, NotificheViewModel viewModel, NotificaItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.titolo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                Text(item.ora, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.messaggio, style: const TextStyle(color: Colors.black54, fontSize: 14, height: 1.3)),
            const SizedBox(height: 16),
            
            // riga con cestino e info aula
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // tasto cestino 
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: "Elimina notifica",
                  onPressed: () => viewModel.eliminaNotifica(item.id),
                ),
                
                // tasto info aula
                ElevatedButton.icon(
                  onPressed: () => viewModel.vaiAlDettaglioAula(context, item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text("INFO AULA", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}