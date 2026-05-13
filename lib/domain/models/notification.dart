import 'package:intl/intl.dart';

class Notification {
  final String notificaId; // Chiamata NotificationModel per evitare conflitti con classi Flutter
  final int creatoreNotifica;    // matricola di chi crea la notifica
  final int destinatario;       // matricola di chi riceve la notifica (non usata per ora, ma utile per future estensioni)
  final String titolo;       // Es: "Lezione spostata"
  final String messaggio;    // Es: "La lezione di Analisi è stata spostata in A1.2"
  final DateTime data;       // Quando è stata inviata
  final bool isLetta;

  Notification({
    required this.notificaId,
    required this.creatoreNotifica,
    required this.destinatario,
    required this.titolo,
    required this.messaggio,
    required this.data,
    required this.isLetta,
  });


  /// Metodo specializzato per aggiornare esclusivamente lo stato di lettura
  Notification copyWith({
    bool? isLetta,
  }) {
    return Notification(
      notificaId: notificaId, 
      creatoreNotifica: creatoreNotifica, 
      destinatario: destinatario, 
      titolo: titolo, 
      messaggio: messaggio, 
      data: data, 
      isLetta: isLetta ?? this.isLetta, // Unico campo aggiornabile
    );
  }


  // Getter per la UI
  String get oraFormattata => DateFormat('HH:mm').format(data);
  String get dataFormattata => DateFormat('dd/MM/yyyy').format(data);


  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificaId: json['notificaId'] as String,
      creatoreNotifica: json['creatoreNotifica'] as int,
      destinatario: json['destinatario'] as int,
      titolo: json['titolo'] as String,
      messaggio: json['messaggio'] as String,
      data: DateTime.parse(json['data'] as String),
      // SQLite non ha i booleani, usiamo 0 e 1
      isLetta: json['isLetta'] == 1, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificaId': notificaId,
      'creatoreNotifica': creatoreNotifica,
      'destinatario': destinatario,
      'titolo': titolo,
      'messaggio': messaggio,
      'data': data.toIso8601String(),
      'isLetta': isLetta ? 1 : 0,
    };
  }
}