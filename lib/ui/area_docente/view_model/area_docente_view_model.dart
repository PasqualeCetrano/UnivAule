import 'package:flutter/material.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view/schermata_prenotazione_view.dart';

class AreaDocenteViewModel extends ChangeNotifier {
  
  void vaiAPrenotazione(BuildContext context) {
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RicercaAuleScreen()),
    );
  }

  void vaiALeTuePrenotazioni(BuildContext context) {
    debugPrint("Navigazione a: Le tue prenotazioni");
  }

  void vaiASegnalaProblema(BuildContext context) {
    debugPrint("Navigazione a: Segnala Problema");
  }

  void vaiANotifiche(BuildContext context) {
    debugPrint("Navigazione a: Notifiche");
  }
}