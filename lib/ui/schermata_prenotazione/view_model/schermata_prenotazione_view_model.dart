import 'package:flutter/material.dart';
// Importiamo la schermata dei risultati per poter navigare verso di essa
import 'package:univ_aule/ui/risultati_ricerca/view/risultati_ricerca_view.dart';

class RicercaAuleViewModel extends ChangeNotifier {
  // --- Stato dei Filtri ---
  String _numeroPosti = "100";
  bool _richiedeProiettore = false;
  bool _richiedePrese = false;
  String _tipoPrese = 'Al muro';
  bool _soloDisponibili = false;

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

  // --- Setters e Logica ---
  void setNumeroPosti(String val) { _numeroPosti = val; notifyListeners(); }
  void setRichiedeProiettore(bool val) { _richiedeProiettore = val; notifyListeners(); }
  void setRichiedePrese(bool val) { _richiedePrese = val; notifyListeners(); }
  void setTipoPrese(String val) { _tipoPrese = val; notifyListeners(); }
  void setSoloDisponibili(bool val) { _soloDisponibili = val; notifyListeners(); }
  void setRicercaManuale(String val) { notifyListeners(); }

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

  // --- Navigazione ---

  // Metodo per la ricerca con i filtri
  void eseguiRicercaFiltri(BuildContext context) {
    debugPrint("Ricerca filtri: $_giornoInt $mese, Posti: $_numeroPosti");
    _navigaAiRisultati(context);
  }

  // Metodo per la ricerca manuale
  void eseguiRicercaManuale(BuildContext context, String query) {
    if (query.isEmpty) return;
    debugPrint("Ricerca manuale per: $query");
    _navigaAiRisultati(context);
  }

  void _navigaAiRisultati(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RisultatiRicercaScreen()),
    );
  }
}