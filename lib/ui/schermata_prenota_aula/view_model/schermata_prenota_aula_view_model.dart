import 'package:flutter/material.dart';
import 'package:univ_aule/ui/area_docente/view/area_docente_view.dart';

// modello per le segnalazioni 
class SegnalazioneAula {
  final String id;
  final String testo;
  final String autore;
  int likes;
  bool isLikedByMe;

  SegnalazioneAula({
    required this.id,
    required this.testo,
    required this.autore,
    required this.likes,
    this.isLikedByMe = false,
  });
}

class DettaglioAulaViewModel extends ChangeNotifier {
  // --- STATO AZIONI ---
  bool _isPrenotata = false;
  bool _inCoda = false;
  bool _isLoading = false;

  bool get isPrenotata => _isPrenotata;
  bool get inCoda => _inCoda;
  bool get isLoading => _isLoading;

  // lista di prova delle segnalazioni
  final List<SegnalazioneAula> _segnalazioni = [
    SegnalazioneAula(
      id: '1', 
      testo: 'Il proiettore ha i colori sfasati (tende al giallo).', 
      autore: 'Prof. Rossi', 
      likes: 4
    ),
    SegnalazioneAula(
      id: '2', 
      testo: 'Riscaldamento bloccato, fa caldissimo vicino alle finestre.', 
      autore: 'Prof.ssa Bianchi', 
      likes: 12, 
      isLikedByMe: true // Simuliamo un like già messo
    ),
    SegnalazioneAula(
      id: '3', 
      testo: 'Mancano 5 sedie rispetto alla capienza ufficiale.', 
      autore: 'Prof. Verdi', 
      likes: 2
    ),
  ];

  List<SegnalazioneAula> get segnalazioni => _segnalazioni;

  // --- LOGICA DI BUSINESS ---

  Future<void> prenotaAula() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 1500));
    
    _isPrenotata = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> mettitiInCoda() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 1500));
    
    _inCoda = true;
    _isLoading = false;
    notifyListeners();
  }

  // Aggiunge o toglie il like a una specifica segnalazione
  void toggleLike(String id) {
    final index = _segnalazioni.indexWhere((s) => s.id == id);
    if (index != -1) {
      final seg = _segnalazioni[index];
      if (seg.isLikedByMe) {
        seg.likes--;
        seg.isLikedByMe = false;
      } else {
        seg.likes++;
        seg.isLikedByMe = true;
      }
      notifyListeners();
    }
  }
// tasto torna alla home (area docente)
  void tornaAllAreaDocente(BuildContext context) {
    _isPrenotata = false;
    _inCoda = false;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AreaDocenteScreen()),
      (route) => route.isFirst,
    );
  }
}
  
