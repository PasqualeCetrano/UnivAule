import '../../domain/models/report.dart';

class ReportService{

  // Database temporaneo in RAM (Statico per essere condiviso tra le pagine)
  static final List<Report> _mockReports = [
    Report(
      id: 1,
      matricola: 123456,
      classroomId: 'A1.1',
      tipoProblema: 'Proiettore',
      priorita: 'Alta',
      descrizione: 'Lo schermo lampeggia continuamente.',
      dataInvio: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Report(id: 2,
      matricola: 654321,
      classroomId: 'B2.3',
      tipoProblema: 'Riscaldamento',
      priorita: 'Media',
      descrizione: 'I termosifoni sono tiepidi.',
      dataInvio: DateTime.now(),
    ),
  ];

  //andiamo a visualizzare i report di un'aula specifica
  Future<List<Report>> fetchReportsForClassroom(String classroomId) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula il caricamento
    
    // Restituisce solo i report che corrispondono all'ID dell'aula selezionata
    return _mockReports.where((r) => r.classroomId == classroomId).toList();
  }

//andiamo ad aggiungere la segnalazione compilata dall'utente, è rappresentata tramite newReport, che è un oggetto Report senza ID (perché lo crea il DB) e con i campi compilati dalla UI. Il metodo restituisce un Future<bool> per confermare alla UI se l'operazione è riuscita o meno.
  Future<bool> sendReport(Report newReport) async {
    await Future.delayed(const Duration(seconds: 1));

    final reportDaAggiungere = Report(
      id: _mockReports.length + 1,
      matricola: newReport.matricola,
      classroomId: newReport.classroomId,
      tipoProblema: newReport.tipoProblema,
      priorita: newReport.priorita,
      descrizione: newReport.descrizione,
      dataInvio: newReport.dataInvio,
    );

    _mockReports.add(reportDaAggiungere);

    print("MOCK DB: Salvato report '${newReport.tipoProblema}' per l'aula ${newReport.classroomId}");
    return true; // Conferma alla UI che l'operazione è riuscita
  }

}