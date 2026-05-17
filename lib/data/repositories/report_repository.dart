import '../services/report_service.dart';
import '../../domain/models/report.dart';

class ReportRepository{

final ReportService _reportService;

  ReportRepository(this._reportService);


/// Verifica se l'utente può inviare una segnalazione
  /// Impedisce alla stessa matricola di segnalare lo stesso problema nella stessa aula per 5 giorni.
  Future<bool> puoUtenteSegnalare(int matricola, String classroomId, String tipoProblema) async {
    // 1. Recuperiamo tutti i report esistenti per quell'aula specifica dal Service
    final tuttiIReport = await _reportService.filtraReportPerClasse(classroomId);

    final bloccato = tuttiIReport.any((r) {
      if (r.matricola == matricola && r.tipoProblema == tipoProblema) {

        // Prendiamo la data del vecchio report e ci sommiamo 5 giorni per trovare la data di sblocco
        final dataSblocco = r.dataInvio.add(const Duration(days: 5));
        
        // Se il momento attuale (DateTime.now) viene PRIMA della data di sblocco,
        // significa che i 5 giorni non sono ancora passati! (L'utente è bloccato)
        return DateTime.now().isBefore(dataSblocco);
      }
      return false;
    });
    // Se l'utente NON è bloccato (false), il metodo restituisce true (può segnalare).
    return !bloccato; 
  }


  /// Riceve i parametri dalla UI/ViewModel e costruisce l'oggetto Report.
  //questo metodo viene chiamato anche quando l'utente interagisce direttamente con il pollice
  Future<bool> creaEInviaSegnalazione({
    required int matricola,
    required String classroomId,
    required String tipo,
    required String priorita,
    required String descrizione,
  }) async {
    try {
      bool permesso = await puoUtenteSegnalare(matricola, classroomId, tipo);
      if (!permesso) {
        print("REPO: Segnalazione bloccata per la matricola $matricola (troppo recente per questo problema)");
        return false; // Operazione respinta (il ViewModel avviserà la UI)
      }

      //Costruiamo l'oggetto Report completo.
      final nuovoReport = Report(
        reportId: DateTime.now().millisecondsSinceEpoch, 
        matricola: matricola,
        classroomId: classroomId,
        tipoProblema: tipo,
        priorita: priorita,
        descrizione: descrizione,
        dataInvio: DateTime.now(),
      );

      return await _reportService.inviaReport(nuovoReport);
      
    } catch (e) {
      print("REPO ERROR: Errore durante il processo di segnalazione: $e");
      return false;
    }
  }


  /// Recupera i report di un'aula e li raggruppa per 'tipoProblema'.
  /// Restituisce una lista di mappe contenenti il primo report e il conteggio dei pollici ('upvotes').
  Future<List<Map<String, dynamic>>> ottieniSegnalazioniAggregateClasse(String classroomId) async {
    // 1. Recuperiamo la lista di tutti i report dell'aula dal Service
    List<Report> tuttiIReport = await _reportService.filtraReportPerClasse(classroomId);
    
    // 2. Mappa di supporto per raggruppare (Chiave della mappa: tipoProblema)
    Map<String, Map<String, dynamic>> raggruppati = {};

    for (var report in tuttiIReport) {
      if (!raggruppati.containsKey(report.tipoProblema)) {
        // Prima segnalazione di questo tipo incontrata nella lista
        raggruppati[report.tipoProblema] = {
          'report': report,
          'upvotes': 1, // Parte da 1 (la prima persona che ha riscontrato il guasto)
        };
      } else {
        //il ! serve a dire che la mappa contiene già quel tipo di problema,
        // quindi possiamo accedere in sicurezza al campo 'upvotes' e 
        //incrementarlo senza avere il rischio di trovare la mappa null
        raggruppati[report.tipoProblema]!['upvotes'] += 1;
      }
    }

    // 3. Trasformiamo i valori della mappa in una lista pronta per il ListView della UI
    return raggruppati.values.toList();
  }


}