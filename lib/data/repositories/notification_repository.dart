import '../../domain/models/notification.dart' as my;
import '../services/notification_service.dart';

class NotificationRepository {
  // Istanza del service per accedere ai dati mock/database
  final NotificationService _notificationService;

  NotificationRepository(this._notificationService);

  /// Carica le notifiche e le prepara per la UI
  Future<List<my.Notification>> getNotifiche(int matricola) async {
    try {
      // Chiamiamo il service che si occupa del filtraggio e ordinamento
      return await _notificationService.filtraNotifichePerUtente(matricola);
    } catch (e) {
      print("REPO ERROR: Impossibile recuperare le notifiche: $e");
      return [];
    }
  }

  /// Quando l'utente clicca su una singola notifica
  Future<void> setNotificaComeLetta(String id) async {
    await _notificationService.segnaComeLetta(id);
  }

  /// Restituisce il conteggio per il badge (il numerino rosso)
  Future<int> getConteggio(int matricola) async {
    return await _notificationService.getNotificheNonLette(matricola);
  }
}