import 'package:flutter/material.dart';
import 'package:univ_aule/ui/area_docente/view/area_docente_view.dart';

class SchermataLoginViewModel extends ChangeNotifier { 
  String _email = "";
  String _password = "";
  bool _isLoading = false;

// getter per email, password e isLoading
  String get email => _email;
  String get password => _password; 
  bool get isLoading => _isLoading; 

  // Metodi per aggiornare email e password 
  void updateEmail(String value) {
    _email = value; // Aggiorna l'email e notifica la View
    notifyListeners(); 
  }

  void updatePassword(String value) {
    _password = value; // Aggiorna la password e notifica la View
    notifyListeners();
  }

// Funzione Login (per ora solo simulata)
Future<void> login(BuildContext context) async { //azione asincrona
    _isLoading = true; //caricamento
    notifyListeners(); //cambia view

    await Future.delayed(const Duration(seconds: 1)); // finto timer di caricamento 

    _isLoading = false; //smette di caricare
    notifyListeners(); //cambia view

    // Navigazione all'Area Docente
    if (context.mounted) { //verifice che la pagina sia ancora "viva"
      Navigator.pushReplacement( // prende la pagina login e la sostituisce con l' area docente 
        context,
        MaterialPageRoute(builder: (context) => const AreaDocenteScreen()),
      );
    } //se l'utente va indietro, non torna alla schermata login ma esce dall'app
  }
}