import 'package:flutter/material.dart';

// Modello dati per lo storico delle prenotazioni
class PrenotazioneItem {
  final String id;
  final String nomeAula;
  final String orario;
  final String data;

  PrenotazioneItem({
    required this.id,
    required this.nomeAula,
    required this.orario,
    required this.data,
  });
}

class MiePrenotazioniViewModel extends ChangeNotifier {
  // Dati simulati basati sul tuo mockup
  final List<PrenotazioneItem> _prenotazioni = [
    PrenotazioneItem(
      id: '1',
      nomeAula: 'Aula Rossa (A.1.8) - Blocco 1',
      orario: '8:30-9:30',
      data: '27 Aprile 2026',
    ),
    PrenotazioneItem(
      id: '2',
      nomeAula: 'Aula Verde (A.2.3) - Blocco 1',
      orario: '9:30-13:30',
      data: '16 Maggio 2026',
    ),
    PrenotazioneItem(
      id: '3',
      nomeAula: 'A1.6 - Blocco 0',
      orario: '14:30-16:30',
      data: '20 Maggio 2026',
    ),
  ];

  List<PrenotazioneItem> get prenotazioni => _prenotazioni;

  // Funzione chiamata quando si clicca su una prenotazione
  void vaiAlDettaglio(BuildContext context, String prenotazioneId) {
    debugPrint("Apro i dettagli per annullamento della prenotazione: $prenotazioneId");
    // In futuro: Navigator.push(...) per aprire la schermata di annullamento
  }
}