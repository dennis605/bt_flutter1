import 'package:flutter/material.dart';
import 'bewohner_page.dart';
import 'betreuer_page.dart';
import 'veranstaltung_page.dart';
import 'tagesplan_page.dart'; // Importiere die Tagesplan-Seite

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'CRUD App Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Bewohner verwalten'),
              onTap: () {
                Navigator.pop(context); // Schließt den Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BewohnerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.supervisor_account),
              title: Text('Betreuer verwalten'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BetreuerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Veranstaltungen verwalten'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VeranstaltungPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Tagespläne verwalten'), // Neuer Eintrag für Tagespläne
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TagesplanPage()), // Zur Tagesplan-Seite navigieren
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Willkommen zur CRUD-App',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
