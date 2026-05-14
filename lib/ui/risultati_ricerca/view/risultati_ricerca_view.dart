import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/risultati_ricerca_view_model.dart';

class RisultatiRicercaScreen extends StatelessWidget {
  const RisultatiRicercaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RisultatiRicercaViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'RISULTATI RICERCA', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Aule trovate:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: viewModel.risultati.isEmpty
                  ? const Center(
                      child: Text(
                        "Nessuna aula corrisponde ai filtri selezionati.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.risultati.length,
                      itemBuilder: (context, index) {
                        final aula = viewModel.risultati[index];
                        return _buildAulaCard(context, viewModel, aula);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAulaCard(BuildContext context, RisultatiRicercaViewModel viewModel, RisultatoAula aula) {
    final Color coloreStato = aula.isDisponibile ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3, // Fornisce l'ombra in modo nativo
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Fondamentale: impedisce alla grafica di coprire il bordo colorato interno
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => viewModel.vaiAlDettaglioAula(context, aula.id),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // Applichiamo il bordo verde o rosso a sinistra
            border: Border(
              left: BorderSide(color: coloreStato, width: 6),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aula.isDisponibile ? "Disponibile" : "Occupata",
                style: TextStyle(color: coloreStato, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                aula.nome,
                // Forziamo il colore nero per visibilità contro la Dark Mode
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      aula.orario, 
                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500)
                    ),
                  ),
                  if (!aula.isDisponibile && aula.professore != null)
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          aula.professore!, 
                          style: TextStyle(fontSize: 13, color: Colors.grey[800])
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}