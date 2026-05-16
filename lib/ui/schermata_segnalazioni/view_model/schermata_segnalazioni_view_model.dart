import 'package:flutter/material.dart';

class SegnalazioneViewModel extends ChangeNotifier {
  // variabili di stato per i campi del form
  String _matricola = '';
  String _tipoProblema = 'Generale'; // valore di default
  String _aula = 'A1.1'; // valore di default
  String _descrizione = '';
  bool _isSubmitting = false;

  // getters
  String get matricola => _matricola;
  String get tipoProblema => _tipoProblema;
  String get aula => _aula;
  String get descrizione => _descrizione;
  bool get isSubmitting => _isSubmitting;

  // setters
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

  // funzione async per invio della segnalazione (simulazione)
  Future<bool> inviaSegnalazione() async {
    // validazione della segnalazione (matricola e descrizione non vuoti)
    if (_matricola.isEmpty || _descrizione.isEmpty) {
      debugPrint("Errore: Compilare i campi obbligatori");
      return false;
    }

    _isSubmitting = true;
    notifyListeners();

    // simulazione invio dati al db
    debugPrint("Invio segnalazione per aula $_aula...");
    await Future.delayed(const Duration(seconds: 2));

    _isSubmitting = false;
    // reset dei campi dopo invio
    _matricola = '';
    _descrizione = '';
    notifyListeners();
    
    return true; // ritorna true se l'invio ha avuto successo
  }
}