import 'package:intl/intl.dart';

class Report {
  final int? reportId;           // ID autoincrementale (gestito dal DB)
  final int matricola;    // FK verso la tabella Users (chi segnala)
  final String classroomId;  // FK verso la tabella Classrooms (dove è il guasto)
  final String tipoProblema; 
  final String descrizione;  
  final DateTime dataInvio;  
  final String priorita;

  Report({
    this.reportId,
    required this.matricola,
    required this.classroomId,
    required this.tipoProblema,
    required this.descrizione,
    required this.dataInvio,
    required this.priorita,
  });

  String get formattedDate => DateFormat('d MMMM yyyy', 'it_IT').format(dataInvio);


  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['reportId'] as int?,
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
      'reportId': reportId,
      'matricola': matricola,
      'classroomId': classroomId,
      'tipoProblema': tipoProblema,
      'descrizione': descrizione,
      'dataInvio': dataInvio.toIso8601String(),
      'priorita': priorita,
    };
  }

}