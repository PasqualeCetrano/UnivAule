import 'package:flutter/material.dart';
import 'package:univ_aule/ui/schermata_login/view/schermata_login_view.dart';

class HomeViewModel extends ChangeNotifier {
  
  void selezionaRuolo(BuildContext context, String ruolo) { // funzione che gestisce il click sui bottoni ruolo
    if (ruolo == 'DOCENTE') {
      Navigator.push( // Reindirizza alla schermata di login
        context,
        MaterialPageRoute(builder: (context) => const SchermataLoginView()),
      );
    } else if (ruolo == 'STUDENTE') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("L'Area Studenti è attualmente in fase di sviluppo."),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}