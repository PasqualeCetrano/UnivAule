import '../services/classroom_service.dart';
import '../services/report_service.dart';
import '../services/notification_service.dart';
import '../../domain/models/classroom.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/report.dart';
import '../../domain/models/classroomstatus.dart';
import '../../domain/models/notification.dart';
import 'package:flutter/material.dart';
import '../../domain/models/notification.dart' as my;

class ClassroomRepository{

//riferimento al Service
final ClassroomService _classroomService;
final ReportService _reportService;
final NotificationService _notificationService;

// 2. Costruttore: riceve l'istanza del Service (Dependency Injection)
  ClassroomRepository({required ClassroomService classroomService, required ReportService reportService, required NotificationService notificationService}) 
      : _classroomService = classroomService,
        _reportService = reportService,
        _notificationService = notificationService;


  // --- METODI LATO STUDENTE ---

  /// Cerca le aule che corrispondono al testo inserito (es: "A1")
  /// Serve per popolare la lista dei suggerimenti nella UI.
  Future<List<Classroom>> cercaSuggerimentiAula(String query) async {
    try {
      // Recupera tutte le aule dal Service
      //tramite il type-inference il tipo di tutteLeAule è List<Classroom>
      final List<Classroom> tutteLeAule = await _classroomService.getClassrooms();

      // Pulisce la query dell'utente
      final cleanQuery = query.trim().toLowerCase();

      // Se non ha scritto nulla, restituiamo lista vuota
      if (cleanQuery.isEmpty) return [];

      // Filtriamo per ID dell'aula
      final filtrante = tutteLeAule.where((aula) {
        return aula.id.toLowerCase().contains(cleanQuery);
      }).toList();

      // Ordiniamo alfabeticamente per rendere la UI più ordinata
      filtrante.sort((a, b) => a.id.compareTo(b.id));

      return filtrante;
    } catch (e) {
      print("REPO ERROR (cercaSuggerimenti): $e");
      return [];
    }
  }


  Future<Map<String, dynamic>> getDettagliAulaCompleti(String classroomId) async {
  try {
    // 1. Recupero dati aula
    final tutteLeAule = await _classroomService.getClassrooms();
    final aula = tutteLeAule.firstWhere(
      (a) => a.id == classroomId,
      orElse: () => throw Exception("Aula non trovata"),
    );

    // 2. Recupero segnalazioni
    final tutteLeSegnalazioni = await _reportService.fetchReportsForClassroom(classroomId);

    // 3. Filtro temporale (ultimi 30 giorni)
    final limiteTrentaGiorni = DateTime.now().subtract(const Duration(days: 30));
    
    final segnalazioniRecenti = tutteLeSegnalazioni.where((report) {
      return report.dataInvio.isAfter(limiteTrentaGiorni);
    }).toList();

    // 4. Restituzione pacchetto pulito
    return {
      'aula': aula,
      'segnalazioni': segnalazioniRecenti,
    };

  } catch (e) {
    // In caso di errore (DB offline, ID errato, ecc.)
    return {
      'aula': null,
      'segnalazioni': <Report>[],
    };
  }
}


  /// Recupera l'agenda di un'aula specifica per una determinata data.
  /// La Repository qui filtra i dati per mostrare allo Studente solo ciò che serve.
  Future<List<Schedule>> getAgendaAulaPerStudente(String classroomId, DateTime dataScelta) async {
    try {
      // Chiamiamo il metodo del Service che abbiamo già scritto e testato
      final agendaGrezza = await _classroomService.fetchSchedules(classroomId, dataScelta);

      // LOGICA DI BUSINESS: Lo studente deve vedere solo le lezioni CONFERMATE.
      // Non mostriamo le persone in coda per non creare confusione sul calendario.
      final agendaFiltrata = agendaGrezza
          .where((s) => s.stato.toLowerCase() == 'confermata')
          .toList();

      return agendaFiltrata;
    } catch (e) {
      print("REPO ERROR (getAgendaAula): $e");
      return [];
    }
  }


  //RICERCA PER MATERIA
  Future<List<Schedule>> cercaPerMateria(String query) async {
  try {
    // 1. Prendiamo TUTTE le prenotazioni da tutte le aule
    final List<Schedule> tutti = await _classroomService.getAllSchedules();
    
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) return [];

    // 2. Filtriamo per il nome della materia
    final risultati = tutti.where((s) {
      return s.materia.toLowerCase().contains(cleanQuery);
    }).toList();

    // 3. Ordiniamo per data e ora (per mostrare prima le lezioni più vicine)
    risultati.sort((a, b) => a.orarioInizio.compareTo(b.orarioInizio));
      return risultati;
    } catch (e) {
      print("REPO ERROR (cercaPerMateria): $e");
      return [];
    }
  }





// --- METODI LATO DOCENTE ---



// --- LOGICA DISPONIBILITÀ DOCENTE ---

  ///Restituisce i risultati impacchettati in ClassroomStatus.
  /// Il parametro [soloDisponibili] decide se filtrare la lista o mostrare tutto.
  Future<List<ClassroomStatus>> cercaAule({
    required int minPosti,
    required DateTime dataScelta,
    required TimeOfDay oraInizio,
    required TimeOfDay oraFine,
    bool? richiedeProiettore,
    bool? vuolePrese,
    String? tipoPreseSpecifico,
    bool soloDisponibili = false, // in questo caso il docente vuole vedere tutto (libere e occupate)
  }) async {
    try {
      final auleIdonee = await _classroomService.searchClassrooms(
        minPosti: minPosti,
        richiedeProiettore: richiedeProiettore,
        vuolePrese: vuolePrese,
        tipoPreseSpecifico: tipoPreseSpecifico,
      );

      List<ClassroomStatus> risultati = [];

      for (var aula in auleIdonee) {
        final impegni = await _classroomService.fetchSchedules(aula.id, dataScelta);

        Schedule? impegnoConflittuale;
        try {
          impegnoConflittuale = impegni.firstWhere((lezione) {

            // Convertiamo i DateTime della lezione in TimeOfDay 
            // per poterli confrontare con quelli scelti dal prof
            final inizioL = TimeOfDay.fromDateTime(lezione.orarioInizio);
            final fineL = TimeOfDay.fromDateTime(lezione.orarioFine);
            return lezione.stato.toLowerCase() == 'confermata' &&
                   sovrapposizione(inizioL, fineL, oraInizio, oraFine);
          });
        } catch (e) {
          impegnoConflittuale = null;
        }

        final status = ClassroomStatus(
          aula: aula,
          disponibile: impegnoConflittuale == null,
          conflitto: impegnoConflittuale,
        );

        // Se il prof vuole solo le libere, aggiungiamo solo se disponibile == true.
        // Altrimenti aggiungiamo sempre.
        if (!soloDisponibili || status.disponibile) {
          risultati.add(status);
        }
      }

      // Ordiniamo in modo che lo scarto minore appaia per primo
      //effettua una sottrazione tra le differenze e posizione per primo il + piccolo
      risultati.sort((a, b) => 
        (a.aula.posti - minPosti).compareTo(b.aula.posti - minPosti)
      );

      return risultati;
    } catch (e) {
      print("REPO ERROR: $e");
      return [];
    }
  }


  //metodo per verificare se una delle prenotazioni di un'aula si 
  //sovrappongono con gli orari indicati dal prof
    bool sovrapposizione(TimeOfDay inizioE, TimeOfDay fineE, TimeOfDay inizioR, TimeOfDay fineR) {
      // Trasformiamo tutto in minuti per un confronto numerico semplice
      final startE = inizioE.hour * 60 + inizioE.minute;
      final endE = fineE.hour * 60 + fineE.minute;
      final startR = inizioR.hour * 60 + inizioR.minute;
      final endR = fineR.hour * 60 + fineR.minute;

      //se entrambe vere = conflitto
      //se una delle due è falsa = no conflitto
      return startR < endE && endR > startE;
    }


//metodo per creare una nuova prenotazione in base ai bottoni cliccati dall'utente
  Future<bool> creaPrenotazione({
    required String classroomId,
    required int matricolaDocente,
    required String nomeDocente,
    required String cognomeDocente,
    required String materia,
    required String tipoLezione, // es: 'lezione', 'esame', 'seminario'
    required DateTime dataScelta,
    required TimeOfDay oraInizio,
    required TimeOfDay oraFine,
    required String stato, // 'confermata' o 'in_coda'
  }) async {
    try {
      //Creiamo i DateTime completi (Giorno + Ora)
      //abbiamo i parametri di tipo TimeOfDay, in quanto i Widgets lavorno con questo tipo di parametri
      final DateTime inizioDT = DateTime(
        dataScelta.year,
        dataScelta.month,
        dataScelta.day,
        oraInizio.hour,
        oraInizio.minute,
      );

      final DateTime fineDT = DateTime(
        dataScelta.year,
        dataScelta.month,
        dataScelta.day,
        oraFine.hour,
        oraFine.minute,
      );

      
      final nuovaPrenotazione = Schedule(
        classroomId: classroomId,
        matricola: matricolaDocente, //FK verso il docente
        materia: materia,
        nomeInsegnante: nomeDocente,
        cognomeInsegnante: cognomeDocente,
        orarioInizio: inizioDT, 
        orarioFine: fineDT, 
        creazione: DateTime.now(), // La data di creazione è "adesso"    
        tipo: tipoLezione,
        stato: stato,
      );

      //internamente il service userà nuovaPrenotazione.toJson() per SQLite/API
      return await _classroomService.addSchedule(nuovaPrenotazione);
      
    } catch (e) {
      print("Errore Repository durante la creazione Schedule: $e");
      return false;
    }
  }



  Future<List<Schedule>> PrenotazioniAttive(int matricola) async {
    final List<Schedule> grezzi = await _classroomService.fetchSchedulesByTeacher(matricola);

    // momento in cui il docente apre l'app
    final ora = DateTime.now();

    // Teniamo solo le prenotazioni che finiscono DOPO il momento attuale
    final attive = grezzi.where((s) => s.orarioFine.isAfter(ora)).toList();

    // Ordiniamo:
    attive.sort((a, b) {
      //Stato (Confermate prima)
      int compStato = a.stato.compareTo(b.stato);
      //return compStato : nel caso è -1, mette a prima di b altrimenti se = 1 viceversa
      if (compStato != 0) return compStato;

      //La più imminente prima
      return a.orarioInizio.compareTo(b.orarioInizio);
    });

    return attive;
  }


  Future<void> gestisciAnnullamento(Schedule prenotazioneDaCancellare) async {
    try {
      // 1. ELIMINAZIONE
      bool eliminata = await _classroomService.deleteSchedule(
        classroomId: prenotazioneDaCancellare.classroomId,
        matricola: prenotazioneDaCancellare.matricola,
        orarioInizio: prenotazioneDaCancellare.orarioInizio,
        orarioFine: prenotazioneDaCancellare.orarioFine,
      );

      if (!eliminata) throw Exception("Errore: Impossibile eliminare la prenotazione.");

      // 2. LOGICA DI SUCCESSIONE (Solo se la cancellata era confermata)
      if (prenotazioneDaCancellare.stato == 'confermata') {
        
        final tuttiGliImpegni = await _classroomService.fetchSchedules(
          prenotazioneDaCancellare.classroomId, 
          prenotazioneDaCancellare.orarioInizio
        );

        List<Schedule> candidatiInCoda = tuttiGliImpegni
            .where((s) => s.stato == 'in coda')
            .toList();

        if (candidatiInCoda.isNotEmpty) {
          // Ordiniamo per data di creazione
          candidatiInCoda.sort((a, b) => a.creazione.compareTo(b.creazione));

          for (var candidato in candidatiInCoda) {
            bool haConflitti = tuttiGliImpegni.any((imp) => 
              imp.stato == 'confermata' && 
              sovrapposizione(TimeOfDay.fromDateTime(candidato.orarioInizio), 
                TimeOfDay.fromDateTime(candidato.orarioFine), 
                TimeOfDay.fromDateTime(imp.orarioInizio), 
                TimeOfDay.fromDateTime(imp.orarioFine))
            );

            if (!haConflitti) {
              bool successoUpdate = await _classroomService.updateScheduleStatus(
                classroomId: candidato.classroomId,
                matricola: candidato.matricola,
                orarioInizio: candidato.orarioInizio,
                orarioFine: candidato.orarioFine,
                nuovoStato: 'confermata',
              );

              if (successoUpdate) {
                int index = tuttiGliImpegni.indexOf(candidato);
                tuttiGliImpegni[index] = candidato.copyWith(stato: 'confermata');
                
                  final nuovaNotifica = my.Notification(
                  notificaId: DateTime.now().microsecondsSinceEpoch.toString(),
                  creatoreNotifica: 0, // Il sistema si occuperà di creare le notifiche
                  destinatario: candidato.matricola,
                  titolo: "Prenotazione Confermata!",
                  messaggio: "La tua richiesta per l'aula ${candidato.classroomId} è stata accettata.",
                  data: DateTime.now(),
                  isLetta: false,
                );

                await _notificationService.sendNotification(nuovaNotifica);

                print("Promosso: ${candidato.matricola}");
              }
            }
          } 
        }else {
          print("Non ci sono prenotazione compatibili con le disponibilità");
        }
      } 

    } catch (e) {
      print("Errore critico durante gestisciAnnullamento: $e");
      rethrow;
    }
  }
}
