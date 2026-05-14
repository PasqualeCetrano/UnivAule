import 'package:flutter/material.dart';
import 'package:univ_aule/ui/area_docente/view/area_docente_view.dart';

class SchermataLoginViewModel extends ChangeNotifier { 
  String _email = "";
  String _password = "";
  bool _isLoading = false;
// Aggiunti getter per email, password e isLoading
  String get email => _email;
  String get password => _password; 
  bool get isLoading => _isLoading; 

  void updateEmail(String value) {
    _email = value; // Aggiorna l'email e notifica i listener
    notifyListeners(); 
  }

  void updatePassword(String value) {
    _password = value; // Aggiorna la password e notifica i listener
    notifyListeners();
  }

Future<void> login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); 

    _isLoading = false;
    notifyListeners();

    // Navigazione all'Area Docente (sostituendo la schermata di login)
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AreaDocenteScreen()),
      );
    }
  }
}