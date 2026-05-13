import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view_model/schermata_prenota_aula_view_model.dart';

class DettaglioAulaScreen extends StatelessWidget {
  const DettaglioAulaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DettaglioAulaViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          // Torna indietro ai risultati di ricerca
          onPressed: () => Navigator.of(context).pop(), 
        ),
        title: const Text('PRENOTAZIONE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- SCHEDA INFORMAZIONI AULA ---
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
                    // Intestazione grigia della scheda
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text("A.2.3", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Row(
                            children: [
                              Icon(Icons.home, size: 20),
                              SizedBox(width: 6),
                              Text("Coppito 1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Lista dei dettagli
                    _buildDettaglioRow("Struttura: ", "MESVA"),
                    _buildDettaglioRow("Edificio: ", "Blocco 1 (Renato Ricamo)"),
                    _buildDettaglioRow("Piano: ", "0"),
                    _buildDettaglioRow("Posti: ", "100"),
                    _buildDettaglioRow("Proiettore: ", "disponibile"),
                    _buildDettaglioRow("Prese: ", "al posto"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- BOTTONE PRENOTA AULA (Dinamico) ---
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(
                  color: viewModel.isPrenotata ? Colors.grey : Colors.black,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              // Disabilita il bottone se sta caricando o se è già prenotata
              onPressed: (viewModel.isPrenotata || viewModel.isLoading) 
                ? null 
                : () => viewModel.prenotaAula(),
              icon: viewModel.isLoading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                  : Icon(
                      viewModel.isPrenotata ? Icons.check_circle : Icons.calendar_today,
                      color: Colors.green, // Icona verde come nel mockup
                    ),
              label: Text(
                viewModel.isPrenotata ? "AULA PRENOTATA" : "PRENOTA AULA",
                style: TextStyle(
                  color: viewModel.isPrenotata ? Colors.grey : Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- BOTTONE RITORNO ALLA HOME ---
            // Questo blocco appare SOLO dopo che la prenotazione è andata a buon fine
            if (viewModel.isPrenotata)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 2,
                ),
                onPressed: () => viewModel.tornaAllaHome(context),
                child: const Text(
                  "TORNA ALLA SCHERMATA INIZIALE", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5)
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Funzione helper per creare le righe di testo in modo pulito e riutilizzabile
  Widget _buildDettaglioRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          children: [
            TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}