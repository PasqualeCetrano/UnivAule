import 'report.dart';

class Classroom{

  final String id;         
  final String struttura;     
  final String edificio;      
  final int piano;            
  final int posti;       
  final bool haProiettore;    
  final String tipoPrese;
  List<Report> report;

  Classroom({
    required this.id,
    required this.struttura,
    required this.edificio,
    required this.piano,
    required this.posti,
    required this.haProiettore,
    required this.tipoPrese,
    this.report = const [],
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'] as String,
      struttura: json['struttura'] as String,
      edificio: json['edificio'] as String,
      piano: json['piano'] as int,
      posti: json['posti'] as int,
     // SQLite salva il bool come int (1 o 0)
      haProiettore: json['haProiettore'] == 1, 
      tipoPrese: json['tipoPrese'] as String,
    );
  }

  // TRADUTTORE: Da Oggetto (Domain) a Mappa (SQLite)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'struttura': struttura,
      'edificio': edificio,
      'piano': piano,
      'posti': posti,
      'haProiettore': haProiettore ? 1 : 0, // Convertiamo per il DB
      'tipoPrese': tipoPrese,
    };
  }
}