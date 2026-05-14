import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/mie_prenotazioni_view_model.dart';

class MiePrenotazioniScreen extends StatelessWidget {
  const MiePrenotazioniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MiePrenotazioniViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Sfondo grigio chiarissimo come immagine
      body: SafeArea(
        child: Column(
          children: [
            // --- CUSTOM APP BAR (Come immagine) ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tasto Indietro in un quadrato grigio
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const Text(
                      'LE TUE PRENOTAZIONI',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5),
                    ),
                    // Icona Calendario/Tabella a destra
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.calendar_view_day_outlined, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),

            // --- LISTA PRENOTAZIONI ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: viewModel.prenotazioni.length,
                itemBuilder: (context, index) {
                  return _buildModernCard(context, viewModel, viewModel.prenotazioni[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard(BuildContext context, MiePrenotazioniViewModel viewModel, PrenotazioneItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      // ClipRRect serve per far sì che la barra laterale segua l'arrotondamento della card
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => viewModel.vaiAlDettaglio(context, item.id),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: item.coloreBarra, width: 8), // Barra gialla laterale
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titolo Aula
                Text(
                  item.nomeAula,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                // Riga con i due chip (Pillole)
                Row(
                  children: [
                    // Chip Orario (Grigio scuro)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.orario,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Chip Data (Bordato)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        item.data,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}