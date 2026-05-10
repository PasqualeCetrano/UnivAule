import 'user.dart';

class Student extends User {
  Student({
    required super.matricola,
    required super.nome,
    required super.cognome,
    required super.email,
    required super.password,
  });

  @override
  Map<String, dynamic> toJson() => {
    'matricola': matricola,
    'nome': nome,
    'cognome': cognome,
    'email': email,
    'password': password,
    'ruolo': 'studente', // Valore per il DB
  };
}