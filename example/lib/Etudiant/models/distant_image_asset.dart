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
      id: json['id'].toString(),
      modeleName: json['nom'],
      modelLink: Utils.RootUrl + json['path_modele3d'],
      imageLink: Utils.RootUrl + json['path_image'],
    );
  }
}
