import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_segnalazioni/view_model/schermata_segnalazioni_view_model.dart';

class SegnalazioneScreen extends StatelessWidget {
  const SegnalazioneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SegnalazioneViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('SEGNALA UN PROBLEMA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CAMPO: Numero di Matricola
            const Text("Numero di Matricola", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              onChanged: viewModel.updateMatricola,
              decoration: InputDecoration(
                hintText: "Inserisci il tuo numero di matricola",
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CAMPO: Tipo di problema
            const Text("Tipo di problema", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: viewModel.tipoProblema,
                  items: ['Generale', 'Tecnico', 'Pulizia'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: viewModel.updateTipoProblema,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CAMPO: Aula
            const Text("Aula", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: viewModel.aula,
                  items: ['A1.1', 'A1.2', 'A1.3', 'Aula Rossa'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: viewModel.updateAula,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CAMPO: Descrizione (Multiline)
            TextField(
              onChanged: viewModel.updateDescrizione,
              maxLines: 6, // Rende il box di testo bello grande come nel mockup
              decoration: InputDecoration(
                hintText: "Descrivi il tuo problema...",
                hintStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // BOTTONE INVIA
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700], // Colore blu acceso
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: viewModel.isSubmitting
                    ? null
                    : () async {
                        // Aspettiamo che il ViewModel finisca di processare
                        final success = await viewModel.inviaSegnalazione();
                        if (success && context.mounted) {
                          // Mostriamo un feedback all'utente
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Segnalazione inviata con successo!')),
                          );
                          // Torniamo indietro alla home
                          Navigator.of(context).pop();
                        }
                      },
                child: viewModel.isSubmitting
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("Invia", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}