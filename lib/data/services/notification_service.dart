import '../../domain/models/notification.dart' as my;// Per evitare conflitti con la classe Notification di Flutter

class NotificationService{

  // 1. Database temporaneo in RAM (Statico per mantenere i dati tra le pagine)
    static final List<my.Notification> _mockNotifications = [
      my.Notification(
        notificaId: 'notif_001',
        creatoreNotifica: 987654, // Matricola del docente che ha annullato
        destinatario: 123456,
        titolo: 'Aula Assegnata',
        messaggio: 'Ti è stata assegnata l\'aula A1.1 a seguito di uno slittamento dalla coda.',
        data: DateTime.now().subtract(const Duration(hours: 2)),
        isLetta: false,
      ),
    ];


  /// Recupera tutte le notifiche indirizzate a un determinato utente (Docente o Studente)
    Future<List<my.Notification>> filtraNotifichePerUtente(int matricolaDestinatario) async {
      // Simula il ritardo del caricamento da database
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Filtriamo le notifiche dove il destinatario corrisponde alla matricola passata
      final filtered = _mockNotifications
          .where((n) => n.destinatario == matricolaDestinatario)
          .toList();
      
      // Ordiniamo dalla più recente alla più vecchia
      filtered.sort((a, b) => b.data.compareTo(a.data));
      
      return filtered;
    }

  //Restituisce il numero di notifiche non ancora lette, così da far comparire il numero sulla UI
    Future<int> getNotificheNonLette(int matricola) async {
      await Future.delayed(const Duration(milliseconds: 100));
      return _mockNotifications
          .where((n) => n.destinatario == matricola && !n.isLetta)
          .length;
    }


    /// Cambia lo stato di una notifica da non letta a letta
  Future<bool> segnaComeLetta(String idNotifica) async {
    // 1. Cerchiamo l'indice della notifica nella lista tramite il suo ID univoco
    int index = _mockNotifications.indexWhere((n) => n.notificaId == idNotifica);

    // 2. Se l'indice è -1, la notifica non è stata trovata
    if (index != -1) {
      // 3. Creiamo una copia della notifica con isLetta impostato a true
      // Usiamo il metodo copyWith che abbiamo definito nel Notification.dart
      _mockNotifications[index] = _mockNotifications[index].copyWith(isLetta: true);
      
      print("SERVICE: Notifica $idNotifica segnata come letta.");
      return true;
    }
    
    print("SERVICE: Notifica $idNotifica non trovata.");
    return false;
  }


    /// Aggiunge una nuova notifica (metodo chiamato dalla Repository dopo uno slittamento o annullamento)
    Future<bool> inviaNotifica(my.Notification newNotification) async {
      await Future.delayed(const Duration(milliseconds: 300));
      
      try {
        _mockNotifications.add(newNotification);
        print("SERVICE: Notifica salvata correttamente per l'utente ${newNotification.destinatario}");
        return true;
      } catch (e) {
        print("SERVICE ERROR: Errore nel salvataggio della notifica: $e");
        return false;
      }
    }


}