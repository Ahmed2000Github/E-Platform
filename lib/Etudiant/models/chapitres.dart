class Chapitres {
  int id;
  String titre;

  Chapitres({
    this.id, this.titre
  });

  factory Chapitres.fromJson(Map<String, dynamic> json) {
    return Chapitres(
      id: json['id'],
      titre: json['title']
    );
  }

}
