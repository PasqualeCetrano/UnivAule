import '../../domain/models/classroom.dart';
import '../../domain/models/schedule.dart';

class ClassroomService{

// Dati Mock static
    static final List<Classroom> mockClassrooms = [
      Classroom(
        id: 'A1.1',
        struttura: 'Struttura A',
        edificio: 'Edificio 1',
        piano: 1,
        posti: 30,
        haProiettore: true,
        tipoPrese: 'Al muro',
      ),
      Classroom(
        id: 'B2.3',
        struttura: 'Struttura B',
        edificio: 'Edificio 2',
        piano: 2,
        posti: 20,
        haProiettore: false,
        tipoPrese: 'Nessuna',
      ),
      Classroom(
      id: 'C1.5',
      struttura: 'Struttura A',
      edificio: 'Edificio 1',
      piano: 0,
      posti: 50,
      haProiettore: true,
      tipoPrese: 'Sui banchi',
    ),
    ];


 // Dati di esempio
    static final List<Schedule> allSchedules = [
      Schedule(
        classroomId: 'A1.1',
        matricola: 123456,
        materia: 'Analisi Matematica',
        nomeInsegnante: 'Antonio',
        cognomeInsegnante: 'Rossi',
        orarioInizio: DateTime(2024, 4, 27, 9, 30),
        orarioFine: DateTime(2024, 4, 27, 11, 30),
        tipo: 'Lezione',
      ),
      Schedule(
        classroomId: 'B2.3',
        matricola: 654321,
        materia: 'Fisica',
        nomeInsegnante: 'Antonella',
        cognomeInsegnante: 'Bianchi',
        orarioInizio: DateTime(2024, 4, 28, 14, 0),
        orarioFine: DateTime(2024, 4, 28, 16, 0),
        tipo: 'Conferenza',
      ),
      Schedule(
        classroomId: 'A1.1',
        matricola: 987654,
        materia: 'Informatica Generale',
        nomeInsegnante: 'Giuseppe',
        cognomeInsegnante: 'Verdi',
        orarioInizio: DateTime(2024, 4, 27, 14, 00),
        orarioFine: DateTime(2024, 4, 27, 16, 00),
        tipo: 'Laboratorio',
      ),
    ];


 Future<List<Classroom>> getClassrooms() async {
    // Simulazione di un ritardo per l'ottenimento dei dati
    await Future.delayed(const Duration(seconds: 1));
    return mockClassrooms;
  }


  // ci restituisce l'aula e la data selezionata dall'utente es 27 aprile per A1.1
  Future<List<Schedule>> fetchSchedules(String classroomId, DateTime selectedDate) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final filtrate = allSchedules.where((s) => 
      s.classroomId == classroomId && 
      s.orarioInizio.year == selectedDate.year &&
      s.orarioInizio.month == selectedDate.month &&
      s.orarioInizio.day == selectedDate.day
    ).toList();

filtrate.sort((a,b) => a.orarioInizio.compareTo(b.orarioInizio));

    return filtrate;

  }


//rappresenta la ricerca per le credenziali inserite dal docente rispetto alle aule disponibili, con i filtri applicati
  Future<List<Classroom>> searchClassrooms({
    required int minPosti,
    bool? richiedeProiettore,
    bool? vuolePrese, // Il checkbox della UI
    String? tipoPreseSpecifico, // (es. "Al muro")
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return mockClassrooms.where((aula) {
      // 1. Filtro Posti: l'aula DEVE avere almeno i posti richiesti
      final matchPosti = aula.posti >= minPosti;
      
      // 2. Filtro Proiettore: se null, passa tutto; se true/false, deve coincidere
      final matchProiettore = richiedeProiettore == null || aula.haProiettore == richiedeProiettore;

      // Logica Prese: se il checkbox è attivo, controlliamo il tipo
      bool matchPrese = true; 
        if (vuolePrese == true) { //Se l'utente ha attivato il filtro
        //Sovrascriviamo matchPrese con il risultato del confronto
        matchPrese = aula.tipoPrese == tipoPreseSpecifico; 
        }

      //se l'aula rispetta tutti i requisiti viene aggiunta alla lista delle aule da restituire
      return matchPosti && matchProiettore && matchPrese;
    }).toList();
  }


  // Aggiunge una nuova prenotazione (confermata o in coda), a decidere se è in coda o confermata è la Repository
  Future<bool> addSchedule(Schedule newSchedule) async {
    // Simuliamo il caricamento (ritardo del database)
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // In questa fase Mock, aggiungiamo semplicemente all'elenco in memoria
      allSchedules.add(newSchedule);
      
      // In futuro con SQLite sarà: 
      // await db.insert('schedules', newSchedule.toMap());
      
      print("Prenotazione salvata con successo: ${newSchedule.materia} in ${newSchedule.classroomId}");
      return true;
    } catch (e) {
      print("Errore durante il salvataggio: $e");
      return false;
    }
  }


  /// Recupera tutte le prenotazioni fatte da un singolo docente e le restituisce dalla più recente alla 
  /// più vecchia, per mostrarle nella sezione "Le mie prenotazioni"
  Future<List<Schedule>> fetchSchedulesByTeacher(int matricola) async {
    await Future.delayed(const Duration(milliseconds: 400));
    List<Schedule> prenotazioni = allSchedules.where((s) => s.matricola == matricola).toList();
    prenotazioni.sort((a, b) => b.orarioInizio.compareTo(a.orarioInizio));
    return prenotazioni;
  }

  //DA RIVEDERE BENE IL FUNZIONAMENTO
  /// Sostituisce una prenotazione esistente con una nuova (es. cambio stato)
  /// Sfrutta il rimpiazzamento dell'oggetto per mantenere l'immutabilità
  /// Cambia lo stato di una prenotazione esistente (da 'in_coda' a 'confermata')
  Future<bool> updateScheduleStatus({
    required String classroomId,
    required int matricola,
    required DateTime orarioInizio,
    required DateTime orarioFine,
    required String nuovoStato,
  }) async {
    try {
      // 1. Cerchiamo l'indice della riga esistente tramite la chiave composta
      int index = allSchedules.indexWhere((s) => 
        s.classroomId == classroomId &&
        s.matricola == matricola &&
        s.orarioInizio == orarioInizio &&
        s.orarioFine == orarioFine
      );

// index ci restituisce la riga in cui si trova la prenotazione per quell'aula in quell'orario
      if (index != -1) {
        // 2. Usiamo copyWith per creare il nuovo oggetto con lo stato aggiornato
        // e rimpiazziamo il vecchio nella lista, poichè sappiamo che gli 
        //oggetti una volta creati non possono essere modificati
        allSchedules[index] = allSchedules[index].copyWith(stato: nuovoStato);
        print("Successione completata: Prenotazione di $matricola ora è $nuovoStato");
        return true;
      }
      return false;
    } catch (e) {
      print("Errore durante l'aggiornamento stato: $e");
      return false;
    }
  }


  /// Rimuove definitivamente una prenotazione (quando un docente rinuncia)
  Future<bool> deleteSchedule({
    required String classroomId,
    required int matricola,
    required DateTime orarioInizio,
    required DateTime orarioFine,
  }) async {
    try {
      allSchedules.removeWhere((s) => 
        s.classroomId == classroomId &&
        s.matricola == matricola &&
        s.orarioInizio == orarioInizio &&
        s.orarioFine == orarioFine
      );
      print("Prenotazione rimossa per il docente $matricola");
      return true;
    } catch (e) {
      return false;
    }
  }


}