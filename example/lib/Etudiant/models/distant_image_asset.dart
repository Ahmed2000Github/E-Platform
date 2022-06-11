import 'package:arcore_flutter_plugin_example/Etudiant/models/utils.dart';

class DsitantImageAsset {
  final String id;
  final String modeleName;
  final String imageLink;
  final String modelLink;

  DsitantImageAsset({
    this.id,
    this.imageLink,
    this.modeleName,
    this.modelLink,
  });

// mapage des donnees
  factory DsitantImageAsset.fromJson(Map<String, dynamic> json) {
    return DsitantImageAsset(
      id: json['id'],
      modeleName: json['titre_traitement'],
      modelLink:
          Utils.RootUrl.split('/cours/api').first + json['path_modele3d'],
      imageLink: Utils.RootUrl.split('/cours/api').first + json['path_image'],
    );
  }
}
