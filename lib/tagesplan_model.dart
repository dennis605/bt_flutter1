import 'veranstaltung_model.dart';

class Tagesplan {
  DateTime datum;
  List<Veranstaltung> veranstaltungen;

  Tagesplan({
    required this.datum,
    required this.veranstaltungen,
  });

  // Methode zum Erstellen eines Tagesplans aus JSON
  factory Tagesplan.fromJson(Map<String, dynamic> json) {
    return Tagesplan(
      datum: DateTime.parse(json['datum']),
      veranstaltungen: List<Veranstaltung>.from(json['veranstaltungen'].map((v) => Veranstaltung.fromJson(v))),
    );
  }

  // Methode zum Konvertieren eines Tagesplans in JSON
  Map<String, dynamic> toJson() {
    return {
      'datum': datum.toIso8601String(),
      'veranstaltungen': veranstaltungen.map((v) => v.toJson()).toList(),
    };
  }
}
