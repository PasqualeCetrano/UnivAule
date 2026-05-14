import 'package:flutter/material.dart';
import 'package:univ_aule/ui/mie_prenotazioni/view/mie_prenotazioni_view.dart';
import 'package:univ_aule/ui/schermata_notifiche/view/schermata_notifiche_view.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view/schermata_prenotazione_view.dart';
import 'package:univ_aule/ui/schermata_segnalazioni/view/schermata_segnalazioni_view.dart';

class AreaDocenteViewModel extends ChangeNotifier {
  
  // 1. Navigazione a Prenota Aula
  void vaiAPrenotazione(BuildContext context) {
    debugPrint("Navigazione a: Ricerca Aule");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RicercaAuleScreen()),
    );
  }

  // 2. Navigazione a Le mie prenotazioni
  void vaiALeTuePrenotazioni(BuildContext context) {
    debugPrint("Navigazione a: Cronologia Prenotazioni");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MiePrenotazioniScreen()),
    );
  }

  // 3. Navigazione a Segnala un problema
  void vaiASegnalaProblema(BuildContext context) {
    debugPrint("Navigazione a: Form Segnalazioni");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SegnalazioneScreen()),
    );
  }

  // 4. Navigazione a Notifiche
  void vaiANotifiche(BuildContext context) {
    debugPrint("Navigazione a: Centro Notifiche");
    // Se non hai ancora creato la schermata NotificheScreen, 
    // puoi commentare questa navigazione temporaneamente per evitare errori
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificheScreen()),
    );
    
  }
}