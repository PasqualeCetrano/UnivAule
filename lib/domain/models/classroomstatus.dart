import '../../domain/models/classroom.dart';
import '../../domain/models/schedule.dart';

class ClassroomStatus{

final Classroom aula;
final bool disponibile;
final Schedule? conflitto;

ClassroomStatus({
    required this.aula,
    required this.disponibile,
    this.conflitto,
  });

  // Getter di utilità per la UI
  String get infoOccupazione => 
      disponibile ? "Disponibile" : "Occupata da: ${conflitto?.materia}";

}