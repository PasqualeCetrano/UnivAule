import 'student.dart';
import 'teacher.dart';

abstract class User {
  final int matricola; // Sostituisce l'id
  final String nome;
  final String cognome;
  final String email;
  final String password;

  User({
    required this.matricola,
    required this.nome,
    required this.cognome,
    required this.email,
    required this.password,
  });

//ci servono per capire che tipo di ruolo ha l'utente in maniera 
//da decidere quali bottoni devono comparire e quali no
bool get isDocente => this is Teacher;
  bool get isStudente => this is Student;

//metodo comune ereditatop dalle sottoclassi per convertire l'oggetto in json da salvare nel db
  factory User.fromJson(Map<String, dynamic> json) {
    final ruolo = (json['ruolo'] as String).toLowerCase();
    if (ruolo == 'docente') {
      return Teacher(
        matricola: json['matricola'] as int,
        nome: json['nome'] as String,
        cognome: json['cognome'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
      );
    } else {
      return Student(
        matricola: json['matricola'] as int,
        nome: json['nome'] as String,
        cognome: json['cognome'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
      );
    }
  }

//metodo astratto da implementare nelle sottoclassi
  Map<String, dynamic> toJson();

}
