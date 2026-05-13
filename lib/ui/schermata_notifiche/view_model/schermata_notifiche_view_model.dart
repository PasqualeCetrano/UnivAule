import 'package:flutter/material.dart';

// Modello dati per la singola notifica
class NotificaDocente {
  final String id;
  final String messaggio;
  final String data;
  final String ora;
  final String idAula; // Utile per sapere quale aula aprire con il tasto "Info"

  NotificaDocente({
    required this.id, 
    required this.messaggio, 
    required this.data, 
    required this.ora, 
    required this.idAula
  });
}

class NotificheViewModel extends ChangeNotifier {
  // Lista iniziale (mockup) per simulare le notifiche ricevute
  final List<NotificaDocente> _notifiche = [
    NotificaDocente(
      id: '1',
      messaggio: "L'Aula A.2.4 (Blocco 1) ora è libera. Puoi effettuare la prenotazione.",
      data: "12/04/2026",
      ora: "12:00",
      idAula: "A.2.4",
    ),
    NotificaDocente(
      id: '2',
      messaggio: "L'Aula Rossa (Coppito 0) è tornata disponibile per domani.",
      data: "12/04/2026",
      ora: "09:30",
      idAula: "Aula Rossa",
    ),
  ];

  // Getter per leggere la lista dalla View
  List<NotificaDocente> get notifiche => _notifiche;

  // Funzione per eliminare una notifica tramite il suo ID
  void rimuoviNotifica(String id) {
    _notifiche.removeWhere((n) => n.id == id);
    notifyListeners(); // Ricarica la UI facendo sparire la card
  }
}