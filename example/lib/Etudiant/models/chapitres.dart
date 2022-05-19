class Chapitres {
  int id;
  String libelle;
  String description;
  String image ; 

  Chapitres({
    this.id, 
    this.libelle,
    this.description,
    this.image,
  });

  factory Chapitres.fromJson(Map<String, dynamic> json) {
    return Chapitres(
      id: json['id'],
      libelle: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }

}
