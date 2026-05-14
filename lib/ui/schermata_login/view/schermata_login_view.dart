import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Attenzione: verifica che il percorso del tuo ViewModel sia corretto
import '../view_model/schermata_login_view_model.dart';

class SchermataLoginView extends StatelessWidget {
  const SchermataLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SchermataLoginViewModel>(); // Ascolta i cambiamenti del ViewModel

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), 
      body: Center( //per mantenere tutto al centro 
        child: SingleChildScrollView( // Sempre per evitare overflow su schermi piccoli
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 70, color: Colors.blue[900]),
              const SizedBox(height: 16),
              Text(
                "UnivAule",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),

              // Contenitore del Login 
              Container(
                width: double.infinity, // occupa tutto lo schermo disponibile
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0), // fatto più alto 
                decoration: BoxDecoration( // decorazione del box
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [  // ombra leggera
                    BoxShadow( 
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                  // linea gialla sopra
                  border: const Border(
                    top: BorderSide(color: Color(0xFFFFEB3B), width: 6),
                  ),
                ),
                child: Column( // scritta e campi email e password
                  children: [
                    // titolo
                    const Text(
                      "Effettua il Login",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.black87
                      ),
                    ),
                    const SizedBox(height: 8),
                    // sottitolo con istruzioni
                    const Text(
                      "Inserisci le credenziali di ateneo per accedere",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 35),

                    // campo Email
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email istituzionale",
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder( // bordo quando non è selezionato
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder( // bordo quando è selezionato
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade900),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo Password
                    TextField(
                      obscureText: true, // nasconde il testo per la password
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade900),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Bottone Accedi
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900], 
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        // Durante il caricamento il bottone si disabilita per evitare doppi click
                        onPressed: viewModel.isLoading 
                            ? null 
                            : () => viewModel.login(context),
                        child: viewModel.isLoading
                            ? const SizedBox(
                                height: 24, 
                                width: 24, 
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)
                              )
                            : const Text(
                                "ACCEDI", 
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}