class Salle {
  final int id;
  final String nom_salle;
  final bool disponible;

  Salle({this.id, this.nom_salle = '', this.disponible = true});

  factory Salle.fromJson(Map<String, dynamic> json) {
    return Salle(
      id: json['id'],
      nom_salle: json['nom_salle'],
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'disponible': disponible,
      };
}
