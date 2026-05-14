import 'package:flutter/material.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view/schermata_prenota_aula_view.dart';

class RisultatoAula {
  final String id;
  final String nome;
  final bool isDisponibile;
  final String orario;
  final String? professore;

  RisultatoAula({ 
    required this.id,
    required this.nome,
    required this.isDisponibile,
    required this.orario,
    this.professore,
  });
}

class RisultatiRicercaViewModel extends ChangeNotifier {
  // card di prova
  final List<RisultatoAula> _risultati = [
    RisultatoAula(
      id: '1',
      nome: 'Aula Rossa (A.1.8) - Blocco 1',
      isDisponibile: false,
      orario: '9:30-13:30',
      professore: 'Prof. Stefano Smriglio',
    ),
    RisultatoAula(
      id: '2',
      nome: 'Aula Verde (A.2.3) - Blocco 1',
      isDisponibile: true,
      orario: '9:30-13:30',
    ),
    RisultatoAula(
      id: '3',
      nome: 'Aula A1.6 - Blocco 0',
      isDisponibile: false, 
      orario: '14:30-16:30',
      professore: 'Prof. Rossi',
    ),
  ];

  List<RisultatoAula> get risultati => _risultati;

 // non passo solo l'id aula ma tutto l'oggetto 
  void vaiAlDettaglioAula(BuildContext context, RisultatoAula aulaSelezionata) {
    debugPrint("Apro dettaglio aula: ${aulaSelezionata.nome} - Disponibile: ${aulaSelezionata.isDisponibile}");
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DettaglioAulaScreen(
          isDisponibile: aulaSelezionata.isDisponibile,
          nomeAula: aulaSelezionata.nome,
          professore: aulaSelezionata.professore,
        ),
      ),
    );
  }
}