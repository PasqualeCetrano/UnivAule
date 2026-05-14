import 'package:flutter/material.dart';
import 'package:univ_aule/ui/annulla_prenotazioni/view/annulla_prenotazioni_view.dart';


class PrenotazioneItem {
  final String id;
  final String nomeAula;
  final String orario;
  final String data;
  final Color coloreBarra; 

  PrenotazioneItem({
    required this.id, 
    required this.nomeAula, 
    required this.orario, 
    required this.data,
    this.coloreBarra = const Color(0xFFFFD600),
  });
}

class MiePrenotazioniViewModel extends ChangeNotifier {
  final List<PrenotazioneItem> _prenotazioni = [
    PrenotazioneItem(
      id: '1',
      nomeAula: 'Aula Rossa (A.1.8) - Blocco 1',
      orario: '8:30-9:30',
      data: '27 Aprile 2026',
    ),
    PrenotazioneItem(
      id: '2',
      nomeAula: 'Aula Verde (A.2.3) - Blocco 1',       // per ora dati provvisori, poi da collegare al backend
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
// per andare nella schermata di annullamento prenotazione 
  void vaiAlDettaglio(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AnnullamentoPrenotazioneScreen()),
    );
  }
}