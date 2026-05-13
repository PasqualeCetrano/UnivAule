import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/mie_prenotazioni_view_model.dart';

class MiePrenotazioniScreen extends StatelessWidget {
  const MiePrenotazioniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MiePrenotazioniViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('LE TUE PRENOTAZIONI', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        actions: const [
          Icon(Icons.book_online, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.prenotazioni.length,
        itemBuilder: (context, index) {
          final prenotazione = viewModel.prenotazioni[index];
          // Passiamo "index == 0" per simulare il fatto che il primo elemento
          // abbia lo stile del "link blu" come nel tuo mockup
          return _buildPrenotazioneCard(context, viewModel, prenotazione, index == 0);
        },
      ),
    );
  }

  Widget _buildPrenotazioneCard(BuildContext context, MiePrenotazioniViewModel viewModel, PrenotazioneItem prenotazione, bool isFirstItem) {
    return GestureDetector(
      onTap: () => viewModel.vaiAlDettaglio(context, prenotazione.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          // Bordo giallo a sinistra, bordi sottili e grigi altrove
          border: Border(
            left: const BorderSide(color: Color(0xFFFFEB3B), width: 6), // Giallo UnivAule
            top: BorderSide(color: Colors.grey.shade300, width: 1),
            right: BorderSide(color: Colors.grey.shade300, width: 1),
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome dell'Aula (Se è il primo, lo facciamo blu e sottolineato come nel mockup)
              Text(
                prenotazione.nomeAula,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isFirstItem ? Colors.blue[700] : Colors.black87,
                  decoration: isFirstItem ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 16),
              
              // Riga con Badge Orario e Badge Data
              Row(
                children: [
                  // Badge Orario (Sfondo grigio pieno)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      prenotazione.orario,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Badge Data (Solo contorno grigio)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      prenotazione.data,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}