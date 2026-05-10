import 'package:intl/intl.dart';

class Notification { // Chiamata NotificationModel per evitare conflitti con classi Flutter
  final int creatoreNotifica;    // matricola di chi crea la notifica
  final int destinatario;       // matricola di chi riceve la notifica (non usata per ora, ma utile per future estensioni)
  final String titolo;       // Es: "Lezione spostata"
  final String messaggio;    // Es: "La lezione di Analisi è stata spostata in A1.2"
  final DateTime data;       // Quando è stata inviata
  bool isLetta;

  Notification({
    required this.creatoreNotifica,
    required this.destinatario,
    required this.titolo,
    required this.messaggio,
    required this.data,
    this.isLetta = false,    // Di base una nuova notifica non è letta
  });

  String get oraFormattata => DateFormat('HH:mm').format(data);

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      creatoreNotifica: json['matricola'] as int,
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
      'matricola': creatoreNotifica,
      'destinatario': destinatario,
      'titolo': titolo,
      'messaggio': messaggio,
      'data': data.toIso8601String(),
      'isLetta': isLetta ? 1 : 0,
    };
  }
}