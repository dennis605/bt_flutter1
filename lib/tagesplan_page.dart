import 'package:flutter/material.dart';
import 'tagesplan_model.dart';
import 'veranstaltung_model.dart';
import 'veranstaltung_page.dart'; // Um Veranstaltungen auszuwählen

class TagesplanPage extends StatefulWidget {
  const TagesplanPage({super.key});

  @override
  _TagesplanPageState createState() => _TagesplanPageState();
}

class _TagesplanPageState extends State<TagesplanPage> {
  // Liste der Tagespläne
  List<Tagesplan> tagesplaeneListe = [];

  // Datum und Veranstaltungen für den aktuellen Tagesplan
  DateTime? ausgewaehltesDatum;
  List<Veranstaltung> ausgewaehlteVeranstaltungen = [];

  // Datumsauswahl für den Tagesplan
  Future<void> _pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        ausgewaehltesDatum = selectedDate;
      });
    }
  }

  // Tagesplan hinzufügen
  void _addTagesplan() {
    if (ausgewaehltesDatum == null || ausgewaehlteVeranstaltungen.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte Datum und mindestens eine Veranstaltung auswählen.'),
        ),
      );
      return;
    }

    setState(() {
      tagesplaeneListe.add(Tagesplan(
        datum: ausgewaehltesDatum!,
        veranstaltungen: List.from(ausgewaehlteVeranstaltungen),
      ));
    });

    // Formular zurücksetzen
    ausgewaehltesDatum = null;
    ausgewaehlteVeranstaltungen = [];
  }

  // Veranstaltung hinzufügen (von einer anderen Seite auswählen)
  Future<void> _addVeranstaltung(BuildContext context) async {
    // Navigation zur Veranstaltungsauswahl (z.B. VeranstaltungPage)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VeranstaltungPage()), // Veranstaltungsauswahl
    );

    if (result is Veranstaltung) {
      setState(() {
        ausgewaehlteVeranstaltungen.add(result);
      });
    }
  }

  // Tagesplan löschen
  void _deleteTagesplan(int index) {
    setState(() {
      tagesplaeneListe.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagespläne verwalten'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Datumsauswahl für den Tagesplan
              ListTile(
                title: Text(
                  ausgewaehltesDatum == null
                      ? 'Datum auswählen *'
                      : 'Datum: ${ausgewaehltesDatum!.toLocal()}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              const SizedBox(height: 20),

              // Veranstaltungen zum Tagesplan hinzufügen
              ElevatedButton(
                onPressed: () => _addVeranstaltung(context),
                child: const Text('Veranstaltung hinzufügen'),
              ),
              const SizedBox(height: 20),

              // Liste der ausgewählten Veranstaltungen anzeigen
              if (ausgewaehlteVeranstaltungen.isNotEmpty) ...[
                const Text('Veranstaltungen im Tagesplan:'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ausgewaehlteVeranstaltungen.length,
                  itemBuilder: (context, index) {
                    final veranstaltung = ausgewaehlteVeranstaltungen[index];
                    return ListTile(
                      title: Text(veranstaltung.name),
                      subtitle: Text('Ort: ${veranstaltung.ort}\nBetreuer: ${veranstaltung.betreuer.vorname} ${veranstaltung.betreuer.nachname}'),
                    );
                  },
                ),
              ],
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _addTagesplan,
                child: const Text('Tagesplan erstellen'),
              ),
              const Divider(),

              // Liste der Tagespläne anzeigen
              ListView.builder(
                shrinkWrap: true,
                itemCount: tagesplaeneListe.length,
                itemBuilder: (context, index) {
                  final tagesplan = tagesplaeneListe[index];
                  return ListTile(
                    title: Text('Tagesplan: ${tagesplan.datum.toLocal()}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tagesplan.veranstaltungen.map((veranstaltung) {
                        return Text('• ${veranstaltung.name}');
                      }).toList(),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTagesplan(index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
