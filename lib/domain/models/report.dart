import 'package:intl/intl.dart';

class Report {
  final int id;           // ID autoincrementale (gestito dal DB)
  final int matricola;    // FK verso la tabella Users (chi segnala)
  final String classroomId;  // FK verso la tabella Classrooms (dove è il guasto)
  final String tipoProblema; 
  final String descrizione;  
  final DateTime dataInvio;  
  final String priorita;

  Report({
    required this.id,
    required this.matricola,
    required this.classroomId,
    required this.tipoProblema,
    required this.descrizione,
    required this.dataInvio,
    required this.priorita,
  });

  String get formattedDate => DateFormat('d MMMM yyyy', 'it_IT').format(dataInvio);

//da vedere bene se serve
  String get summary => '$tipoProblema - $classroomId';


  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      matricola: json['matricola'] as int,
      classroomId: json['classroomId'] as String,
      tipoProblema: json['tipoProblema'] as String,
      descrizione: json['descrizione'] as String,
      dataInvio: DateTime.parse(json['dataInvio'] as String),
      priorita: json['priorita'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // L'ID non lo mettiamo se facciamo un INSERT (lo crea il DB)
      // ma lo includiamo se stiamo aggiornando un report esistente
      'matricola': matricola,
      'classroomId': classroomId,
      'tipoProblema': tipoProblema,
      'descrizione': descrizione,
      'dataInvio': dataInvio.toIso8601String(),
      'priorita': priorita,
    };
  }

}