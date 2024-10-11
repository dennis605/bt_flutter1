class Betreuer {
  String vorname;
  String nachname;
  int alter;
  String kommentar;

  Betreuer({
    required this.vorname,
    required this.nachname,
    required this.alter,
    required this.kommentar,
  });

  // Methode zum Erstellen eines Betreuer-Objekts aus einem JSON-Objekt
  factory Betreuer.fromJson(Map<String, dynamic> json) {
    return Betreuer(
      vorname: json['vorname'],
      nachname: json['nachname'],
      alter: json['alter'],
      kommentar: json['kommentar'],
    );
  }

  // Methode zum Umwandeln eines Betreuer-Objekts in ein JSON-Objekt
  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'alter': alter,
      'kommentar': kommentar,
    };
  }
}
