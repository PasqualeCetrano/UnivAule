import 'package:flutter/material.dart';
import 'package:univ_aule/ui/risultati_ricerca/view/risultati_ricerca_view.dart';

class RicercaAuleViewModel extends ChangeNotifier {
  // stato filtri
  String _numeroPosti = ""; 
  bool _richiedeProiettore = false;
  bool _richiedePrese = false;
  String _tipoPrese = 'Al muro';
  bool _soloDisponibili = false;

  // dati di prova
  final List<String> auleDisponibili = [
    "Aula Rossa (A.1.8) - Blocco 1",
    "Aula Verde (A.2.3) - Blocco 1",
    "Aula A1.6 - Blocco 0",
    "Laboratorio Turing",
    "Laboratorio Alan",
    "Aula Magna (Coppito 1)",
    "Aula C2.1 - Blocco 2"
  ];

  // stato data
  int _giornoInt = 27;
  String _meseSelezionato = "Aprile";

  final List<String> mesi = [
    "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
    "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"
  ];

  // stato orari 
  final List<String> ore = List.generate(24, (i) => i.toString().padLeft(2, '0'));
  final List<String> minuti = ['00', '30']; // Solo 00 e 30 

  String _oraInizio = "09";
  String _minutiInizio = "30";
  String _oraFine = "13";
  String _minutiFine = "30";

  // getters
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

  // validazione data
  int _getGiorniNelMese(String mese) {
    if (mese == "Febbraio") {
      int anno = DateTime.now().year;
      bool isBisestile = (anno % 4 == 0 && anno % 100 != 0) || (anno % 400 == 0);
      return isBisestile ? 29 : 28;
    }
    if (["Aprile", "Giugno", "Settembre", "Novembre"].contains(mese)) {
      return 30; 
    }
    return 31; 
  }

  // setters
  void setNumeroPosti(String val) { _numeroPosti = val; notifyListeners(); }
  void setRichiedeProiettore(bool val) { _richiedeProiettore = val; notifyListeners(); }
  void setRichiedePrese(bool val) { _richiedePrese = val; notifyListeners(); }
  void setTipoPrese(String val) { _tipoPrese = val; notifyListeners(); }
  void setSoloDisponibili(bool val) { _soloDisponibili = val; notifyListeners(); }

  void giornoSuccessivo() { 
    int maxGiorni = _getGiorniNelMese(_meseSelezionato);
    if (_giornoInt < maxGiorni) {
      _giornoInt++; 
      notifyListeners(); 
    }
  }
  
  void giornoPrecedente() { 
    if (_giornoInt > 1) {
      _giornoInt--; 
      notifyListeners(); 
    }
  }
  
  void setGiornoManuale(String val) {
    int? nuovoGiorno = int.tryParse(val);
    if (nuovoGiorno != null) {
      int maxGiorni = _getGiorniNelMese(_meseSelezionato);
      if (nuovoGiorno >= 1 && nuovoGiorno <= maxGiorni) {
        _giornoInt = nuovoGiorno;
      } else if (nuovoGiorno > maxGiorni) {
        _giornoInt = maxGiorni;
      } else if (nuovoGiorno < 1) {
        _giornoInt = 1;
      }
      notifyListeners();
    }
  }

  void setMese(String val) { 
    _meseSelezionato = val; 
    int maxGiorni = _getGiorniNelMese(_meseSelezionato);
    if (_giornoInt > maxGiorni) {
      _giornoInt = maxGiorni;
    }
    notifyListeners(); 
  }

  void setOraInizio(String val) { _oraInizio = val; notifyListeners(); }
  void setMinutiInizio(String val) { _minutiInizio = val; notifyListeners(); }
  void setOraFine(String val) { _oraFine = val; notifyListeners(); }
  void setMinutiFine(String val) { _minutiFine = val; notifyListeners(); }

  // logica ricerca e validazione
  void eseguiRicercaFiltri(BuildContext context) {
    if (_numeroPosti.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Attenzione: Inserisci il numero minimo di posti."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return; 
    }
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
    _navigaAiRisultati(context);
  }

  void _navigaAiRisultati(BuildContext context) {
    FocusScope.of(context).unfocus(); // chiude la tastiera
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RisultatiRicercaScreen()),
    );
  }
}