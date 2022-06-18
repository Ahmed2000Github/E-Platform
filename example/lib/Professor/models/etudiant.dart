class Etudiant {
  int id;
  String cne;
  String adresse;
  String path_photos;
  String telephone;
  String code_apogee;


  Etudiant({id, cne, adresse, path_photos, telephone, code_apogee});

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        id: json['id'],
        cne: json['cne'],
        adresse: json['adresse'],
        path_photos: json['path_photos'],
        telephone: json['telephone'],
        code_apogee: json['code_apogee'],
      );
}
