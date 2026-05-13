import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_prenotazione/view_model/schermata_prenotazione_view_model.dart';

class RicercaAuleScreen extends StatelessWidget {
  const RicercaAuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RicercaAuleViewModel>();
    final giornoController = TextEditingController(text: viewModel.giorno)
      ..selection = TextSelection.collapsed(offset: viewModel.giorno.length);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('PRENOTAZIONE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filtri:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Box N° Posti e Proiettore
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Text("N° Posti: "),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, fillColor: Colors.white, filled: true),
                      onChanged: viewModel.setNumeroPosti,
                    ),
                  ),
                  const Spacer(),
                  const Text("Proiettore: "),
                  Checkbox(
                    value: viewModel.richiedeProiettore,
                    onChanged: (val) => viewModel.setRichiedeProiettore(val ?? false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Prese e Tendina
            Row(
              children: [
                const Text("Prese: "),
                Checkbox(
                  value: viewModel.richiedePrese,
                  onChanged: (val) => viewModel.setRichiedePrese(val ?? false),
                ),
                if (viewModel.richiedePrese) ...[
                  const SizedBox(width: 16),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: viewModel.tipoPrese,
                        items: ['Al muro', 'Al banco'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                        onChanged: (val) => viewModel.setTipoPrese(val!),
                      ),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 24),

            // Selettore Data con Frecce e Input Manuale
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.chevron_left), onPressed: viewModel.giornoPrecedente),
                  SizedBox(
                    width: 50,
                    height: 35,
                    child: TextField(
                      controller: giornoController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white, contentPadding: EdgeInsets.zero),
                      onSubmitted: viewModel.setGiornoManuale,
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: viewModel.mese,
                    underline: const SizedBox(),
                    items: viewModel.mesi.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                    onChanged: (val) => viewModel.setMese(val!),
                  ),
                  IconButton(icon: const Icon(Icons.chevron_right), onPressed: viewModel.giornoSuccessivo),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Selezione Orari (Tutti gli orari disponibili)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  const Text("Orario di inizio (ora/minuti)"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTimeDropdown(viewModel.oraInizio, viewModel.ore, viewModel.setOraInizio),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text(":")),
                      _buildTimeDropdown(viewModel.minutiInizio, viewModel.minuti, viewModel.setMinutiInizio),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Orario di fine (ora/minuti)"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTimeDropdown(viewModel.oraFine, viewModel.ore, viewModel.setOraFine),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text(":")),
                      _buildTimeDropdown(viewModel.minutiFine, viewModel.minuti, viewModel.setMinutiFine),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Checkbox disponibilità e Tasto Cerca Principale
            Row(
              children: [
                const Text("Solo aule disponibili"),
                Checkbox(value: viewModel.soloDisponibili, onChanged: (v) => viewModel.setSoloDisponibili(v ?? false)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                // COLLEGAMENTO: Esegue la ricerca con i filtri
                onPressed: () => viewModel.eseguiRicercaFiltri(context), 
                child: const Text("Cerca", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            // Sezione Ricerca Manuale
            const SizedBox(height: 30),
            const Center(child: Text("oppure", style: TextStyle(color: Colors.grey))),
            const SizedBox(height: 8),
            const Center(child: Text("Cerca manualmente", style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            TextField(
              // COLLEGAMENTO: Naviga premendo Invio sulla tastiera
              onSubmitted: (query) => viewModel.eseguiRicercaManuale(context, query),
              decoration: InputDecoration(
                hintText: "Cerca...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDropdown(String current, List<String> opts, Function(String) onCh) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: current,
          menuMaxHeight: 300,
          items: opts.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: (v) { if (v != null) onCh(v); },
        ),
      ),
    );
  }
}