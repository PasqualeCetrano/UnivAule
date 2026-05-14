import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_aule/ui/schermata_prenota_aula/view_model/schermata_prenota_aula_view_model.dart';
class DettaglioAulaScreen extends StatelessWidget {
  // parametri presi dai risultati
  final bool isDisponibile;
  final String nomeAula;
  final String? professore;

  const DettaglioAulaScreen({
    super.key, 
    required this.isDisponibile, 
    required this.nomeAula, 
    this.professore,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DettaglioAulaViewModel>();

    // dati di prova
    final nomeProf = professore?.replaceAll('Prof. ', '').replaceAll('Prof.ssa ', '').replaceAll(' ', '.').toLowerCase() ?? 'docente';
    final emailFinta = "$nomeProf@univaq.it";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('DETTAGLIO AULA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // box info aula
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              nomeAula, // nome aula dinamico
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                            ),
                          ),
                          const Icon(Icons.home, size: 20, color: Colors.black87),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDettaglioRow("Posti:", "100"),
                    _buildDettaglioRow("Proiettore:", "Disponibile"),
                    _buildDettaglioRow("Prese:", "Al posto"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // logica aula libera/occupata
            if (isDisponibile) ...[
              // aula disponibile -> pulsante Verde
              _buildActionButton(
                label: viewModel.isPrenotata ? "AULA PRENOTATA" : "PRENOTA AULA",
                icon: viewModel.isPrenotata ? Icons.check_circle : Icons.calendar_today,
                color: Colors.green,
                isLoading: viewModel.isLoading,
                isDone: viewModel.isPrenotata,
                onTap: () => viewModel.prenotaAula(),
              ),
            ] else ...[
              // aula occupata -> pulsante arancione
              _buildActionButton(
                label: viewModel.inCoda ? "SEI IN CODA" : "METTITI IN CODA",
                icon: viewModel.inCoda ? Icons.how_to_reg : Icons.people_alt_outlined,
                color: Colors.orange.shade700,
                isLoading: viewModel.isLoading,
                isDone: viewModel.inCoda,
                onTap: () => viewModel.mettitiInCoda(),
              ),
              const SizedBox(height: 12),
              
              // box con info del professore che occupa l'aula
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: Icon(Icons.person, color: Colors.orange.shade700),
                  ),
                  title: const Text("Attualmente occupata da:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(professore ?? "Docente Sconosciuto", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  trailing: IconButton(
                    icon: const Icon(Icons.mail_outline, color: Colors.blue),
                    onPressed: () {
                      // scritta di prova 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Apertura client mail per: $emailFinta")),
                      );
                    },
                  ),
                ),
              ),
            ],

            // pulsante torna alla schermata iniziale 
            if (viewModel.isPrenotata || viewModel.inCoda) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => viewModel.tornaAllAreaDocente(context),
                child: const Text("TORNA ALLA SCHERMATA INIZIALE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // parte delle segnalazioni
            const Text(
              "Segnalazioni per questa aula",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // per evitare conflitti di scroll con il SingleChildScrollView (suggerimento AI)
              itemCount: viewModel.segnalazioni.length,
              itemBuilder: (context, index) {
                final seg = viewModel.segnalazioni[index];
                return _buildSegnalazioneCard(viewModel, seg);
              },
            ),
          ],
        ),
      ),
    );
  }

  // widget helper 

  Widget _buildDettaglioRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButton({required String label, required IconData icon, required Color color, required bool isLoading, required bool isDone, required VoidCallback onTap}) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: isDone ? Colors.grey : color, width: 2),
        backgroundColor: isDone ? Colors.grey.shade100 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: (isDone || isLoading) ? null : onTap,
      icon: isLoading
          ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5, color: color))
          : Icon(icon, color: isDone ? Colors.grey : color),
      label: Text(
        label,
        style: TextStyle(color: isDone ? Colors.grey : color, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildSegnalazioneCard(DettaglioAulaViewModel viewModel, SegnalazioneAula seg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(seg.testo, style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4)),
                const SizedBox(height: 8),
                Text("Segnalato da: ${seg.autore}", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          InkWell(
            onTap: () => viewModel.toggleLike(seg.id),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: seg.isLikedByMe ? Colors.blue.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: seg.isLikedByMe ? Colors.blue.shade200 : Colors.transparent),
              ),
              child: Row(
                children: [
                  Icon(
                    seg.isLikedByMe ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 16,
                    color: seg.isLikedByMe ? Colors.blue.shade700 : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    seg.likes.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: seg.isLikedByMe ? Colors.blue.shade700 : Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}