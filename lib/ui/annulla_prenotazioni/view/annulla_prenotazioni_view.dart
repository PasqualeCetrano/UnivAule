import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/annulla_prenotazioni/view_model/annulla_prenotazioni_view_model.dart';

class AnnullamentoPrenotazioneScreen extends StatelessWidget {
  const AnnullamentoPrenotazioneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AnnullamentoPrenotazioneViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('PRENOTAZIONE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: const [Icon(Icons.book_online, color: Colors.black), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SCHEDA INFORMAZIONI AULA (Stessa struttura del dettaglio)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text("A.2.3", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              Icon(Icons.home, size: 18),
                              SizedBox(width: 4),
                              Text("Coppito 1", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow("Struttura: ", "MESVA"),
                    _buildInfoRow("Edificio: ", "Blocco 1 (Renato Ricamo)"),
                    _buildInfoRow("Piano: ", "0"),
                    _buildInfoRow("Posti: ", "100"),
                    _buildInfoRow("Proiettore: ", "disponibile"),
                    _buildInfoRow("Prese: ", "al posto"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // BOTTONE ANNULLA PRENOTAZIONE
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: viewModel.isAnnullata ? Colors.grey : Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: (viewModel.isAnnullata || viewModel.isLoading) 
                ? null 
                : () => viewModel.annullaPrenotazione(),
              child: viewModel.isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red))
                : Text(
                    viewModel.isAnnullata ? "PRENOTAZIONE ANNULLATA" : "ANNULLA PRENOTAZIONE",
                    style: TextStyle(
                      color: viewModel.isAnnullata ? Colors.grey : Colors.red, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
            ),

            const SizedBox(height: 16),

            // BOTTONE TORNA ALLA SCHERMATA INIZIALE
            if (viewModel.isAnnullata)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text("TORNA ALLA SCHERMATA INIZIALE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}