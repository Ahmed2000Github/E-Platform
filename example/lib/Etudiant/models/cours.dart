class Cours {
  int id;
  String libelle_module;

  Cours({this.id, this.libelle_module});

// mapage des donnees
  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      libelle_module: json['libelle'],
    );
  }
}
