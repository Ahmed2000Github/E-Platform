class Niveau {
  
  final int id;
  final String nom_niveau;
  final String type_niveau;
  final int filiere;

  Niveau({this.nom_niveau='',this.type_niveau='',this.filiere=0,this.id=0});

  factory Niveau.fromJson(Map<String, dynamic> json) {
    return Niveau(
      nom_niveau: json['nom_niveau'],
      type_niveau: json['type_niveau'],
      id: json['id'],
      filiere: json['filiere'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nom_niveau' : nom_niveau,
    'type_niveau' : type_niveau,
    'id' : id,
    'filiere' : filiere,
  };
}