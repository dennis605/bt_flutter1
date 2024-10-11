class Bewohner {
  String vorname;
  String nachname;
  int alter;
  String kommentar;

  Bewohner({
    required this.vorname,
    required this.nachname,
    required this.alter,
    required this.kommentar,
  });

  // Methode zum Erstellen eines Bewohner-Objekts aus einem JSON-Objekt
  factory Bewohner.fromJson(Map<String, dynamic> json) {
    return Bewohner(
      vorname: json['vorname'],
      nachname: json['nachname'],
      alter: json['alter'],
      kommentar: json['kommentar'],
    );
  }

  // Methode zum Umwandeln eines Bewohner-Objekts in ein JSON-Objekt
  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'alter': alter,
      'kommentar': kommentar,
    };
  }
}
