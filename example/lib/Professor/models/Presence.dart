import 'package:arcore_flutter_plugin_example/Professor/models/Etudiant.dart';

class Presence {
  int id;
  String libelle;
  String username;
  Etudiant etudiant;

  Presence({id,libelle, username,etudiant});

  factory Presence.fromJson(Map<String, dynamic> json) => Presence(
        id: json['id'],
        libelle: json['libelle'],
        username: json['username'],
        etudiant:json['etudiant']
      );
}
