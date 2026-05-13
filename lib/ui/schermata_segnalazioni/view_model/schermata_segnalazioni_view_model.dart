import 'package:flutter/material.dart';

class SegnalazioneViewModel extends ChangeNotifier {
  // Variabili di stato per i campi del form
  String _matricola = '';
  String _tipoProblema = 'Generale'; // Valore di default
  String _aula = 'A1.1'; // Valore di default
  String _descrizione = '';
  bool _isSubmitting = false;

  // Getters
  String get matricola => _matricola;
  String get tipoProblema => _tipoProblema;
  String get aula => _aula;
  String get descrizione => _descrizione;
  bool get isSubmitting => _isSubmitting;

  // Setters (chiamano notifyListeners per aggiornare la UI)
  void updateMatricola(String value) {
    _matricola = value;
    notifyListeners();
  }

  void updateTipoProblema(String? value) {
    if (value != null) {
      _tipoProblema = value;
      notifyListeners();
    }
  }

  void updateAula(String? value) {
    if (value != null) {
      _aula = value;
      notifyListeners();
    }
  }

  void updateDescrizione(String value) {
    _descrizione = value;
    notifyListeners();
  }

  // Funzione asincrona per inviare la segnalazione
  Future<bool> inviaSegnalazione() async {
    // Validazione base: non inviare se matricola o descrizione sono vuoti
    if (_matricola.isEmpty || _descrizione.isEmpty) {
      debugPrint("Errore: Compilare i campi obbligatori");
      return false;
    }

    _isSubmitting = true;
    notifyListeners();

    // Simuliamo l'invio dei dati al database (es. MongoDB)
    debugPrint("Invio segnalazione per aula $_aula...");
    await Future.delayed(const Duration(seconds: 2));

    _isSubmitting = false;
    // Resettiamo i campi dopo l'invio
    _matricola = '';
    _descrizione = '';
    notifyListeners();
    
    return true; // Ritorna true se l'invio ha avuto successo
  }
}