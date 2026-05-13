import 'package:flutter/material.dart';
import 'package:univ_aule/ui/schermata_login/view/schermata_login_view.dart';

class HomeViewModel extends ChangeNotifier {
  void selezionaRuolo(BuildContext context, String ruolo) {
    if (ruolo == 'DOCENTE') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SchermataLoginView()),
      );
    } else {
      debugPrint("Navigazione per Studente non ancora implementata");
    }
  }
}