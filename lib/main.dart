import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/annulla_prenotazioni/view_model/annulla_prenotazioni_view_model.dart';
import 'package:univ_aule/ui/home_screen/view/home_screen_view.dart';
import 'package:univ_aule/ui/home_screen/view_model/home_screen_view_model.dart';
import 'package:univ_aule/ui/mie_prenotazioni/view_model/mie_prenotazioni_view_model.dart';
import 'package:univ_aule/ui/risultati_ricerca/view_model/risultati_ricerca_view_model.dart';

// --- IMPORT DEI VIEWMODEL ---
// Nota: Verifica che i percorsi corrispondano alla tua struttura delle cartelle

import 'package:univ_aule/ui/schermata_login/view_model/schermata_login_view_model.dart';
import 'package:univ_aule/ui/area_docente/view_model/area_docente_view_model.dart';
import 'package:univ_aule/ui/schermata_notifiche/view_model/schermata_notifiche_view_model.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view_model/schermata_prenota_aula_view_model.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view_model/schermata_prenotazione_view_model.dart';
import 'package:univ_aule/ui/schermata_segnalazioni/view_model/schermata_segnalazioni_view_model.dart';



// --- IMPORT DELLA SCHERMATA INIZIALE ---


void main() {
  runApp(
    MultiProvider(
      providers: [
        // Iniezione di tutti i componenti logici (MVVM)
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SchermataLoginViewModel()),
        ChangeNotifierProvider(create: (_) => AreaDocenteViewModel()),
        ChangeNotifierProvider(create: (_) => RicercaAuleViewModel()),
        ChangeNotifierProvider(create: (_) => RisultatiRicercaViewModel()),
        ChangeNotifierProvider(create: (_) => DettaglioAulaViewModel()),
        ChangeNotifierProvider(create: (_) => AnnullamentoPrenotazioneViewModel()),
        ChangeNotifierProvider(create: (_) => MiePrenotazioniViewModel()),
        ChangeNotifierProvider(create: (_) => SegnalazioneViewModel()),
        ChangeNotifierProvider(create: (_) => NotificheViewModel()),
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
      debugShowCheckedModeBanner: false, // Rimuove il banner 'Debug'
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFEB3B), // Giallo istituzionale
          primary: const Color(0xFF0D47A1),   // Blu accademico
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      // L'app inizia dalla Home dove si sceglie il ruolo
      home: const HomeScreen(), 
    );
  }
}