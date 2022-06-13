

class TypeSalle {
  final String libelle;
  final int capacite;


  TypeSalle({this.libelle = '',this.capacite=0});

  factory TypeSalle.fromJson(Map<String, dynamic> json) {
    return TypeSalle(
      libelle: json['libelle'],
      capacite: json['capacite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'capacite': capacite,
      };
}
