import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/home_screen/view_model/home_screen_view_model.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>(); 

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEB3B),
        title: Text(
          "UnivAule", // da scambiare con il logo
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 32.0,
            color: Colors.blue[900], 
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
      ),
      body: SingleChildScrollView( // serve per far scorrere la pagina se lo schermo è piccolo 
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_balance, // icona universitaria
              size: 80, 
              color: Colors.blue[900]?.withValues(alpha: 0.1) 
            ),
            const SizedBox(height: 24),
            const Text(
              "Benvenuto/a !",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          

            const Text( 
              "SCEGLI IL TUO RUOLO", //scritta sotto il benvenuto
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, 
                color: Colors.black54, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 1.5
              ),
            ),

            //Bottoni scelta ruolo

            const SizedBox(height: 24),

            _buildRoleButton( // Bottone Studente
              title: "Studente",
              icon: Icons.school,
              iconColor: Colors.orange,
              onTap: () => viewModel.selezionaRuolo(context, 'STUDENTE'),
            ),

            const SizedBox(height: 20),

            _buildRoleButton(  // Bottone Docente
              title: "Docente",
              icon: Icons.edit_document, 
              iconColor: Colors.blue[900]!,
              onTap: () => viewModel.selezionaRuolo(context, 'DOCENTE'),
            ),
          ],
        ),
      ),
    );
  }

  //widget helper per creare bottoni in modo più pulito e facile da cambiare
  Widget _buildRoleButton({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap, // funzione che non restituisce nulla 
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),
      child: Row(
        children: [
          // cerchio con icona dentro
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1), 
              shape: BoxShape.circle
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          const Spacer(), // spinge la freccia a destra
          // freccia a destra
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}