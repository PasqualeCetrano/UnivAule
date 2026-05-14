import 'package:flutter/material.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view/schermata_prenota_aula_view.dart';

class NotificaItem {
  final String id;
  final String titolo;
  final String messaggio;
  final String ora;
  final String nomeAula;
  final bool aulaDisponibile;
  final String? professoreOccupante;

  NotificaItem({
    required this.id,
    required this.titolo,
    required this.messaggio,
    required this.ora,
    required this.nomeAula,
    required this.aulaDisponibile,
    this.professoreOccupante,
  });
}

class NotificheViewModel extends ChangeNotifier {
  // Lista iniziale delle notifiche (non è più 'final' bloccata, così possiamo eliminarle)
  final List<NotificaItem> _notifiche = [
    NotificaItem(
      id: '1',
      titolo: "Aula Disponibile!",
      messaggio: "L'Aula Rossa (A.1.8) si è appena liberata. Puoi prenotarla ora.",
      ora: "10:30",
      nomeAula: "Aula Rossa (A.1.8) - Blocco 1",
      aulaDisponibile: true,
    ),
    NotificaItem(
      id: '2',
      titolo: "Promemoria Lezione",
      messaggio: "La tua prenotazione in Aula Verde inizia tra 15 minuti.",
      ora: "09:15",
      nomeAula: "Aula Verde (A.2.3) - Blocco 1",
      aulaDisponibile: false,
      professoreOccupante: "Prof. Stefano Smriglio",
    ),
  ];

  List<NotificaItem> get notifiche => _notifiche;

  // --- LOGICA DI ELIMINAZIONE ---
  void eliminaNotifica(String id) {
    // Rimuove dalla lista la notifica che ha l'ID corrispondente
    _notifiche.removeWhere((notifica) => notifica.id == id);
    // Avvisa la View di ridisegnarsi (la card sparirà magicamente)
    notifyListeners();
  }

  // --- LOGICA DI NAVIGAZIONE VERSO INFO AULA ---
  void vaiAlDettaglioAula(BuildContext context, NotificaItem notifica) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DettaglioAulaScreen(
          isDisponibile: notifica.aulaDisponibile,
          nomeAula: notifica.nomeAula,
          professore: notifica.professoreOccupante,
        ),
      ),
    );
  }
}