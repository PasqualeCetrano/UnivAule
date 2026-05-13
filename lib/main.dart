import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/annulla_prenotazioni/view_model/annulla_prenotazioni_view_model.dart';

// --- IMPORT DEI VIEWMODEL ---
// Controlla che questi percorsi ("package:univ_aule/...") riflettano
// i nomi esatti delle cartelle che hai creato in VS Code.

import 'package:univ_aule/ui/home_screen/view/home_screen_view.dart';
import 'package:univ_aule/ui/home_screen/view_model/home_screen_view_model.dart';
import 'package:univ_aule/ui/mie_prenotazioni/view_model/mie_prenotazioni_view_model.dart';
import 'package:univ_aule/ui/risultati_ricerca/view_model/risultati_ricerca_view_model.dart';
import 'package:univ_aule/ui/schermata_login/view_model/schermata_login_view_model.dart';
import 'package:univ_aule/ui/area_docente/view_model/area_docente_view_model.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view_model/schermata_prenota_aula_view_model.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view_model/schermata_prenotazione_view_model.dart';
import 'package:univ_aule/ui/schermata_segnalazioni/view_model/schermata_segnalazioni_view_model.dart';
// Se hai creato la cartella per le notifiche, tieni questo import, altrimenti puoi cancellarlo:

// --- IMPORT DELLA SCHERMATA INIZIALE ---


void main() {
  runApp(
    MultiProvider(
      providers: [
        // "Accendiamo" tutti i ViewModel in modo che siano disponibili in tutta l'app
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SchermataLoginViewModel()),
        ChangeNotifierProvider(create: (_) => AreaDocenteViewModel()),
        ChangeNotifierProvider(create: (_) => RicercaAuleViewModel()),
        ChangeNotifierProvider(create: (_) => RisultatiRicercaViewModel()),
        ChangeNotifierProvider(create: (_) => DettaglioAulaViewModel()),
        ChangeNotifierProvider(create: (_) => AnnullamentoPrenotazioneViewModel()),
        ChangeNotifierProvider(create: (_) => MiePrenotazioniViewModel()),
        ChangeNotifierProvider(create: (_) => SegnalazioneViewModel()),
        // Togli il commento alla riga sotto se hai il ViewModel delle notifiche
        // ChangeNotifierProvider(create: (_) => NotificheViewModel()),
      ],
      child: const UnivAuleApp(),
    ),
  );
}

class UnivAuleApp extends StatelessWidget {
  const UnivAuleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnivAule',
      debugShowCheckedModeBanner: false, // Nasconde la striscetta rossa in alto a destra
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Sfondo bianco di base per tutte le pagine
      ),
      // Il flusso parte ufficialmente da qui!
      home: const HomeScreen(), 
    );
  }
}