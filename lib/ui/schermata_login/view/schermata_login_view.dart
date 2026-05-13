import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_login/view_model/schermata_login_view_model.dart';

class SchermataLoginView extends StatelessWidget { 
  const SchermataLoginView({super.key}); // costruttore della schermata di login

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SchermataLoginViewModel>(); // ottiene il ViewModel
    return Scaffold(
     body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)), // Etichetta per il campo email
                  TextField(
                    onChanged: viewModel.updateEmail,
                    decoration: const InputDecoration(hintText: "Value"),
                  ),
                  const SizedBox(height: 20),
                  const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)), // Etichetta per il campo password
                  TextField(
                    onChanged: viewModel.updatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Value"),
                  ),
                  const SizedBox(height: 30), 
                  SizedBox( // pulsante di accesso che mostra un indicatore di caricamento quando isLoading è true
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: viewModel.isLoading ? null : () => viewModel.login(context), // disabilita il pulsante durante il caricamento
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: viewModel.isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Accedi"),
                    ),
                  ),
                ], 
              ),
            ),
          )
        ),
      ),
    );
  }
}
