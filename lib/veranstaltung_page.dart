import 'package:flutter/material.dart';
import 'veranstaltung_model.dart';
import 'bewohner_model.dart';
import 'betreuer_model.dart';

class VeranstaltungPage extends StatefulWidget {
  const VeranstaltungPage({Key? key}) : super(key: key); // Füge den key hinzu
  @override
  _VeranstaltungPageState createState() => _VeranstaltungPageState();
}

class _VeranstaltungPageState extends State<VeranstaltungPage> {
  // Liste der Veranstaltungen
  List<Veranstaltung> veranstaltungenListe = [];

  // Dummy-Daten für Bewohner und Betreuer
  List<Bewohner> bewohnerDummyListe = [
    Bewohner(vorname: "Max", nachname: "Mustermann", alter: 30, kommentar: "Kommentar 1"),
    Bewohner(vorname: "Erika", nachname: "Mustermann", alter: 25, kommentar: "Kommentar 2"),
    Bewohner(vorname: "Hans", nachname: "Meyer", alter: 35, kommentar: "Kommentar 3"),
  ];

  List<Betreuer> betreuerDummyListe = [
    Betreuer(vorname: "Herr", nachname: "Betreuer", alter: 40, kommentar: "Kommentar A"),
    Betreuer(vorname: "Frau", nachname: "Betreuerin", alter: 35, kommentar: "Kommentar B"),
  ];

  // Auswahl von Bewohnern und Betreuern
  Map<Bewohner, bool> bewohnerCheckboxValues = {}; // Für Checkboxen
  Betreuer? ausgewaehlterBetreuer; // LowerCamelCase ohne Umlaute

  // Controller für das Formular
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ortController = TextEditingController();
  final TextEditingController beschreibungController = TextEditingController();

  // Datum und Zeit auswählen
  DateTime? ausgewaehltesDatum; // LowerCamelCase ohne Umlaute
  TimeOfDay? anfangsZeit;
  TimeOfDay? endZeit;

  @override
  void initState() {
    super.initState();
    // Initialisiere die Bewohner Checkboxen mit "false" (nicht ausgewählt)
    for (var bewohner in bewohnerDummyListe) {
      bewohnerCheckboxValues[bewohner] = false;
    }
  }

  // Funktion zum Hinzufügen einer Veranstaltung
  void _addVeranstaltung() {
    List<Bewohner> ausgewaehlteBewohner = bewohnerCheckboxValues.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (ausgewaehlteBewohner.isEmpty || ausgewaehlterBetreuer == null || ausgewaehltesDatum == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Bitte alle Felder ausfuellen und Teilnehmer auswaehlen.'),
      ));
      return;
    }

    setState(() {
      veranstaltungenListe.add(Veranstaltung(
        name: nameController.text,
        teilnehmendeBewohner: ausgewaehlteBewohner,
        betreuer: ausgewaehlterBetreuer!,
        datum: ausgewaehltesDatum!,
        anfang: DateTime(
            ausgewaehltesDatum!.year, ausgewaehltesDatum!.month, ausgewaehltesDatum!.day, anfangsZeit!.hour, anfangsZeit!.minute),
        ende: DateTime(
            ausgewaehltesDatum!.year, ausgewaehltesDatum!.month, ausgewaehltesDatum!.day, endZeit!.hour, endZeit!.minute),
        ort: ortController.text,
        beschreibung: beschreibungController.text,
      ));
    });

    // Formular zuruecksetzen
    nameController.clear();
    ortController.clear();
    beschreibungController.clear();
    ausgewaehlterBetreuer = null;
    ausgewaehltesDatum = null;
    anfangsZeit = null;
    endZeit = null;

    // Checkboxen zurücksetzen
    for (var bewohner in bewohnerCheckboxValues.keys) {
      bewohnerCheckboxValues[bewohner] = false;
    }
  }

  // Datumsauswahl
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

  // Zeit auswählen
  Future<void> _pickTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          anfangsZeit = pickedTime;
        } else {
          endZeit = pickedTime;
        }
      });
    }
  }

  // Veranstaltung loeschen
  void _deleteVeranstaltung(int index) {
    setState(() {
      veranstaltungenListe.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veranstaltungen verwalten'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Eingabefelder für die Veranstaltung
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Veranstaltungsname'),
              ),
              TextField(
                controller: ortController,
                decoration: const InputDecoration(labelText: 'Ort'),
              ),
              TextField(
                controller: beschreibungController,
                decoration: const InputDecoration(labelText: 'Beschreibung'),
              ),
              const SizedBox(height: 20),

              // Bewohner-Auswahl mit Checkboxen
              const Text('Bewohner auswählen:'),
              Column(
                children: bewohnerCheckboxValues.entries.map((entry) {
                  return CheckboxListTile(
                    title: Text('${entry.key.vorname} ${entry.key.nachname}'),
                    value: entry.value,
                    onChanged: (bool? value) {
                      setState(() {
                        bewohnerCheckboxValues[entry.key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),

              // Dropdown für Betreuerauswahl
              DropdownButtonFormField<Betreuer>(
                decoration: const InputDecoration(labelText: 'Betreuer auswaehlen'),
                items: betreuerDummyListe.map((betreuer) {
                  return DropdownMenuItem<Betreuer>(
                    value: betreuer,
                    child: Text('${betreuer.vorname} ${betreuer.nachname}'),
                  );
                }).toList(),
                onChanged: (betreuer) {
                  setState(() {
                    ausgewaehlterBetreuer = betreuer;
                  });
                },
                value: ausgewaehlterBetreuer,
              ),

              // Datumsauswahl
              ListTile(
                title: Text(
                  ausgewaehltesDatum == null
                      ? 'Datum auswaehlen'
                      : 'Datum: ${ausgewaehltesDatum!.toLocal()}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),

              // Zeit für Anfang und Ende auswählen
              ListTile(
                title: Text(
                  anfangsZeit == null ? 'Anfangszeit auswaehlen' : 'Anfang: ${anfangsZeit!.format(context)}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _pickTime(context, true),
              ),
              ListTile(
                title: Text(
                  endZeit == null ? 'Endzeit auswaehlen' : 'Ende: ${endZeit!.format(context)}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _pickTime(context, false),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addVeranstaltung,
                child: const Text('Veranstaltung hinzufuegen'),
              ),
              const Divider(),
              // Liste der Veranstaltungen anzeigen
              ListView.builder(
                shrinkWrap: true,
                itemCount: veranstaltungenListe.length,
                itemBuilder: (context, index) {
                  final veranstaltung = veranstaltungenListe[index];
                  return ListTile(
                    title: Text(veranstaltung.name),
                    subtitle: Text(
                      'Ort: ${veranstaltung.ort}\nBetreuer: ${veranstaltung.betreuer.vorname} ${veranstaltung.betreuer.nachname}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteVeranstaltung(index);
                      },
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
