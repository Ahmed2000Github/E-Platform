class Filiere {
  final String nom_filiere;
 


  Filiere({this.nom_filiere=''});

  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      nom_filiere: json['nom_filiere'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nom_filiere' : nom_filiere,
  };
}