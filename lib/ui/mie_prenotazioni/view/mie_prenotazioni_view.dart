import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/mie_prenotazioni_view_model.dart';

class MiePrenotazioniScreen extends StatelessWidget {
  const MiePrenotazioniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MiePrenotazioniViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), 
      body: SafeArea(
        child: Column(
          children: [
            // parte alta con tasto indietro, titolo e icona
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // tasto indietro entro un quadrato grigio 
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
                    // icona calendario a destra
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.calendar_view_day_outlined, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),

            // lista prenotazioni
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
// widget helper per le card
  Widget _buildModernCard(BuildContext context, MiePrenotazioniViewModel viewModel, PrenotazioneItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      
      child: ClipRRect( // Arrotonda anche la barra laterale (AI)
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => viewModel.vaiAlDettaglio(context, item.id),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: item.coloreBarra, width: 8), // barra gialla laterale
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // titolo Aula
                Text(
                  item.nomeAula,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                // riga con piccoli box per orario e data
                Row(
                  children: [
                    // box orario
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
                    // box data
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