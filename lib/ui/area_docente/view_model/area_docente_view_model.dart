import 'package:flutter/material.dart';
import 'package:univ_aule/ui/mie_prenotazioni/view/mie_prenotazioni_view.dart';
import 'package:univ_aule/ui/schermata_notifiche/view/schermata_notifiche_view.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view/schermata_prenotazione_view.dart';
import 'package:univ_aule/ui/schermata_segnalazioni/view/schermata_segnalazioni_view.dart';

// --- IMPORT DELLE TUE SCHERMATE ---
// Assicurati che i percorsi corrispondano esattamente alla struttura delle tue cartelle.
// Usa Ctrl+. (o Cmd+.) se VS Code non trova automaticamente i file.


class AreaDocenteViewModel extends ChangeNotifier {
  
  // 1. Navigazione verso la Ricerca Aule
  void vaiAPrenotazione(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RicercaAuleScreen()),
    );
  }

  // 2. Navigazione verso Le Mie Prenotazioni
  void vaiALeTuePrenotazioni(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MiePrenotazioniScreen()),
    );
  }

  // 3. Navigazione verso la Segnalazione Problemi
  void vaiASegnalaProblema(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SegnalazioneScreen()),
    );
  }

  // 4. Navigazione verso le Notifiche
  void vaiANotifiche(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificheScreen()),
    );
  }
}