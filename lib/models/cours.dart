class Cours {
  int id;
  String titre;

  Cours({this.id, this.titre});

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      titre: json['title'],
    );
  }
}
