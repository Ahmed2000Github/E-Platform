import 'package:arcore_flutter_plugin_example/Etudiant/models/utils.dart';

class Chapitres {
  int id;
  String libelle;
  String description;
  String image;

  Chapitres({
    this.id,
    this.libelle,
    this.description,
    this.image,
  });

// mapage des donnees
  factory Chapitres.fromJson(Map<String, dynamic> json) {
    String desc = json['description'];
    if (desc.length > 20) {
      desc = desc.substring(1, 16) + " ...";
    }
    return Chapitres(
      id: json['id'],
      libelle: json['libelle'],
      description: desc,
      image: Utils.RootUrl.split('/cours/api').first + json['image'],
    );
  }
}
