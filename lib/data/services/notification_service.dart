import '../../domain/models/notification.dart';

class NotificationService{

// 1. Database temporaneo in RAM (Statico per mantenere i dati tra le pagine)
  static final List<Notification> _mockNotifications = [
    Notification(
      creatoreNotifica: 987654, // Matricola del docente che ha annullato
      destinatario: 123456,
      titolo: 'Aula Assegnata',
      messaggio: 'Ti è stata assegnata l\'aula A1.1 a seguito di uno slittamento dalla coda.',
      data: DateTime.now().subtract(const Duration(hours: 2)),
      isLetta: false,
    ),
  ];


/// Recupera tutte le notifiche indirizzate a un determinato utente (Docente o Studente)
  Future<List<Notification>> fetchNotificationsForUser(int matricolaDestinatario) async {
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


  /// Aggiunge una nuova notifica (metodo chiamato dalla Repository dopo uno slittamento o annullamento)
  Future<bool> sendNotification(Notification newNotification) async {
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