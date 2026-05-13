import 'package:flutter/material.dart';

class DettaglioAulaViewModel extends ChangeNotifier {
  // Stato interno della prenotazione
  bool _isPrenotata = false;
  bool _isLoading = false;

  // Getters pubblici in sola lettura
  bool get isPrenotata => _isPrenotata;
  bool get isLoading => _isLoading;

  // Logica di business: Effettua la prenotazione
  Future<void> prenotaAula() async {
    // 1. Attiva lo stato di caricamento e avvisa la View
    _isLoading = true;
    notifyListeners();

    // 2. Simula una chiamata di rete al database (es. MongoDB)
    await Future.delayed(const Duration(milliseconds: 1500));

    // 3. Prenotazione completata con successo
    _isPrenotata = true;
    _isLoading = false;
    notifyListeners();
  }

  // Logica di navigazione: Ritorno alla dashboard
  void tornaAllaHome(BuildContext context) {
    debugPrint("Ritorno alla schermata iniziale...");
    // Questo comando "svuota" lo storico di navigazione e torna alla prima pagina
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
  
  // Metodo opzionale se in futuro vorrai resettare lo stato quando esci
  void resetState() {
    _isPrenotata = false;
    _isLoading = false;
  }
}