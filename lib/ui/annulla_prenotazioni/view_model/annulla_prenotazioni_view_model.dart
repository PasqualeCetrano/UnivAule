import 'package:flutter/material.dart';

class AnnullamentoPrenotazioneViewModel extends ChangeNotifier {
  bool _isAnnullata = false;
  bool _isLoading = false;

  bool get isAnnullata => _isAnnullata;
  bool get isLoading => _isLoading;

  Future<void> annullaPrenotazione() async {
    _isLoading = true;
    notifyListeners();

    // Simulazione del processo di cancellazione sul database
    await Future.delayed(const Duration(milliseconds: 1500));

    _isAnnullata = true;
    _isLoading = false;
    notifyListeners();
  }
}