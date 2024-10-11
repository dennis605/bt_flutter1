import 'package:flutter/material.dart';
import 'betreuer_model.dart'; // Betreuermodell importieren

class BetreuerPage extends StatefulWidget {
  @override
  _BetreuerPageState createState() => _BetreuerPageState();
}

class _BetreuerPageState extends State<BetreuerPage> {
  // Liste der Betreuer
  List<Betreuer> betreuerListe = [];

  // Controller für das Formular
  final TextEditingController vornameController = TextEditingController();
  final TextEditingController nachnameController = TextEditingController();
  final TextEditingController alterController = TextEditingController();
  final TextEditingController kommentarController = TextEditingController();

  // Betreuer hinzufügen
  void _addBetreuer() {
    setState(() {
      betreuerListe.add(Betreuer(
        vorname: vornameController.text,
        nachname: nachnameController.text,
        alter: int.parse(alterController.text),
        kommentar: kommentarController.text,
      ));
    });

    // Formular zurücksetzen
    vornameController.clear();
    nachnameController.clear();
    alterController.clear();
    kommentarController.clear();
  }

  // Betreuer löschen
  void _deleteBetreuer(int index) {
    setState(() {
      betreuerListe.removeAt(index);
    });
  }

  // Betreuer bearbeiten
  void _editBetreuer(int index) {
    final betreuer = betreuerListe[index];
    vornameController.text = betreuer.vorname;
    nachnameController.text = betreuer.nachname;
    alterController.text = betreuer.alter.toString();
    kommentarController.text = betreuer.kommentar;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Betreuer bearbeiten'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: vornameController,
                decoration: InputDecoration(labelText: 'Vorname'),
              ),
              TextField(
                controller: nachnameController,
                decoration: InputDecoration(labelText: 'Nachname'),
              ),
              TextField(
                controller: alterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Alter'),
              ),
              TextField(
                controller: kommentarController,
                decoration: InputDecoration(labelText: 'Kommentar'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Speichern'),
              onPressed: () {
                setState(() {
                  betreuerListe[index] = Betreuer(
                    vorname: vornameController.text,
                    nachname: nachnameController.text,
                    alter: int.parse(alterController.text),
                    kommentar: kommentarController.text,
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Betreuer verwalten'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Eingabefelder für Betreuer
                TextField(
                  controller: vornameController,
                  decoration: InputDecoration(labelText: 'Vorname'),
                ),
                TextField(
                  controller: nachnameController,
                  decoration: InputDecoration(labelText: 'Nachname'),
                ),
                TextField(
                  controller: alterController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Alter'),
                ),
                TextField(
                  controller: kommentarController,
                  decoration: InputDecoration(labelText: 'Kommentar'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addBetreuer,
                  child: Text('Betreuer hinzufügen'),
                ),
              ],
            ),
          ),
          Divider(),
          // Liste der Betreuer anzeigen
          Expanded(
            child: ListView.builder(
              itemCount: betreuerListe.length,
              itemBuilder: (context, index) {
                final betreuer = betreuerListe[index];
                return ListTile(
                  title: Text('${betreuer.vorname} ${betreuer.nachname}'),
                  subtitle: Text('Alter: ${betreuer.alter}\nKommentar: ${betreuer.kommentar}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editBetreuer(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteBetreuer(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
