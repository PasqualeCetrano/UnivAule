import 'package:flutter/material.dart';
import 'package:univ_aule/ui/risultati_ricerca/view/risultati_ricerca_view.dart';

class RicercaAuleViewModel extends ChangeNotifier {
  // --- Stato dei Filtri ---
  // Inizializziamo vuoto per testare l'errore!
  String _numeroPosti = ""; 
  bool _richiedeProiettore = false;
  bool _richiedePrese = false;
  String _tipoPrese = 'Al muro';
  bool _soloDisponibili = false;

  // --- DATABASE SIMULATO PER AUTOSUGGERIMENTI ---
  final List<String> auleDisponibili = [
    "Aula Rossa (A.1.8) - Blocco 1",
    "Aula Verde (A.2.3) - Blocco 1",
    "Aula A1.6 - Blocco 0",
    "Laboratorio Turing",
    "Laboratorio Alan",
    "Aula Magna (Coppito 1)",
    "Aula C2.1 - Blocco 2"
  ];

  // --- Stato della Data ---
  int _giornoInt = 27;
  String _meseSelezionato = "Aprile";

  final List<String> mesi = [
    "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
    "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"
  ];

  // --- Stato degli Orari ---
  final List<String> ore = List.generate(24, (i) => i.toString().padLeft(2, '0'));
  final List<String> minuti = List.generate(60, (i) => i.toString().padLeft(2, '0'));

  String _oraInizio = "09";
  String _minutiInizio = "30";
  String _oraFine = "13";
  String _minutiFine = "30";

  // --- Getters ---
  String get numeroPosti => _numeroPosti;
  bool get richiedeProiettore => _richiedeProiettore;
  bool get richiedePrese => _richiedePrese;
  String get tipoPrese => _tipoPrese;
  String get giorno => _giornoInt.toString();
  String get mese => _meseSelezionato;
  String get oraInizio => _oraInizio;
  String get minutiInizio => _minutiInizio;
  String get oraFine => _oraFine;
  String get minutiFine => _minutiFine;
  bool get soloDisponibili => _soloDisponibili;

  // --- Setters ---
  void setNumeroPosti(String val) { _numeroPosti = val; notifyListeners(); }
  void setRichiedeProiettore(bool val) { _richiedeProiettore = val; notifyListeners(); }
  void setRichiedePrese(bool val) { _richiedePrese = val; notifyListeners(); }
  void setTipoPrese(String val) { _tipoPrese = val; notifyListeners(); }
  void setSoloDisponibili(bool val) { _soloDisponibili = val; notifyListeners(); }

  void giornoSuccessivo() { if (_giornoInt < 31) _giornoInt++; notifyListeners(); }
  void giornoPrecedente() { if (_giornoInt > 1) _giornoInt--; notifyListeners(); }
  
  void setGiornoManuale(String val) {
    int? nuovoGiorno = int.tryParse(val);
    if (nuovoGiorno != null && nuovoGiorno >= 1 && nuovoGiorno <= 31) {
      _giornoInt = nuovoGiorno;
      notifyListeners();
    }
  }

  void setMese(String val) { _meseSelezionato = val; notifyListeners(); }
  void setOraInizio(String val) { _oraInizio = val; notifyListeners(); }
  void setMinutiInizio(String val) { _minutiInizio = val; notifyListeners(); }
  void setOraFine(String val) { _oraFine = val; notifyListeners(); }
  void setMinutiFine(String val) { _minutiFine = val; notifyListeners(); }

  // --- LOGICA DI NAVIGAZIONE E VALIDAZIONE ---

  void eseguiRicercaFiltri(BuildContext context) {
    // 1. VALIDAZIONE: Controlla se il campo posti è vuoto
    if (_numeroPosti.trim().isEmpty) {
      // Mostra un banner di errore nativo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Attenzione: Inserisci il numero minimo di posti."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating, // Rende il banner fluttuante e moderno
        ),
      );
      return; // Blocca la navigazione!
    }

    // Se tutto va bene, naviga.
    debugPrint("Ricerca filtri: $_giornoInt $mese, Posti: $_numeroPosti");
    _navigaAiRisultati(context);
  }

  void eseguiRicercaManuale(BuildContext context, String query) {
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inserisci il nome di un'aula per cercare."),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    debugPrint("Ricerca manuale per: $query");
    _navigaAiRisultati(context);
  }

  void _navigaAiRisultati(BuildContext context) {
    // Prima di navigare verso una nuova pagina, puliamo eventuali tastiere aperte
    FocusScope.of(context).unfocus();
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RisultatiRicercaScreen()),
    );
  }
}