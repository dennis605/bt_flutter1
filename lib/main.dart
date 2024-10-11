import 'package:flutter/material.dart';
import 'bewohner_page.dart';
import 'betreuer_page.dart';
import 'veranstaltung_page.dart';  // Importiere die Veranstaltungsseite

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
                Navigator.pop(context);
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
