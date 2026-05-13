
import 'package:intl/intl.dart';

class Schedule{

  final String classroomId; 
  final int matricola;  //come FK nel DB
  final String materia;       
  final String nomeInsegnante;   
  final String cognomeInsegnante; 
  final DateTime orarioInizio;   
  final DateTime orarioFine;     
  final String tipo;
  final String stato;

  Schedule({
    required this.classroomId,
    required this.matricola,
    required this.materia,
    required this.nomeInsegnante,
    required this.cognomeInsegnante,
    required this.orarioInizio,
    required this.orarioFine,
    required this.tipo,
    this.stato = 'confermata',
  });

  // Restituisce la data (es: "27 Aprile")
  String get formattedDate {
    return DateFormat('d MMMM', 'it_IT').format(orarioInizio);
  }

  // Restituisce l'ora di inizio (es: "09:30")
  String get formattedStartTime {
    return DateFormat('HH:mm').format(orarioInizio);
  }

  // Restituisce l'ora di fine (es: "11:30")
  String get formattedEndTime {
    return DateFormat('HH:mm').format(orarioFine);
  }

  // Restituisce l'intervallo completo (es: "09:30 - 11:30")
  String get timeRange {
    return '$formattedStartTime - $formattedEndTime';
  }


/// Crea una copia dell'oggetto esistente sovrascrivendo solo i campi passati.
  /// Se un campo è null, mantiene il valore originale dell'oggetto (this.campo).
  Schedule copyWith({
    String? stato,

  }) {
    return Schedule(
      classroomId: classroomId,
      matricola: matricola,
      materia: materia,
      nomeInsegnante: nomeInsegnante,
      cognomeInsegnante: cognomeInsegnante,
      orarioInizio: orarioInizio,
      orarioFine: orarioFine,
      tipo: tipo,
      stato: stato ?? this.stato,
    );
  }


  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule( // L'ID autoincrementante arriva come int, lo convertiamo in String
      classroomId: json['classroomId'] as String,
      matricola: json['matricola'] as int,
      materia: json['materia'] as String,
      nomeInsegnante: json['nomeInsegnante'] as String,
      cognomeInsegnante: json['cognomeInsegnante'] as String,
      // Convertiamo la stringa salvata nel DB di nuovo in DateTime
      orarioInizio: DateTime.parse(json['orarioInizio'] as String),
      orarioFine: DateTime.parse(json['orarioFine'] as String),
      tipo: json['tipo'] as String,
      stato: json['stato'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classroomId': classroomId,
      'matricola': matricola,
      'materia': materia,
      'nomeInsegnante': nomeInsegnante,
      'cognomeInsegnante': cognomeInsegnante,
      // Salviamo i DateTime come stringhe ISO8601 (formato standard YYYY-MM-DD HH:mm:ss)
      'orarioInizio': orarioInizio.toIso8601String(),
      'orarioFine': orarioFine.toIso8601String(),
      'type': tipo,
      'stato': stato,
    };
  }

}