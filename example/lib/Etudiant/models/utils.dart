// classe contient des donnees utilisees a chaque fois app demarre
import 'distant_image_asset.dart';

class Utils {
  // url de serveur
  static final String RootUrl = "http://192.168.26.82:8000";

  // token de l'utilisateur
  static String token = "token here";

  // temp variable cours Id
  static String coursId = "1";

  // temp variable chapitre Id
  static String chapitreId = "1";

  // liste des modeles et images
  static List<DsitantImageAsset> distantImages = [
    DsitantImageAsset(
        id: "1",
        imageLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/cheval.jpeg",
        modeleName: "cheval",
        modelLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/earth/Cheval.glb"),
    DsitantImageAsset(
        id: "2",
        imageLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/lucan.jpeg",
        modeleName: "lucan",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/Lucane.glb"),
    DsitantImageAsset(
        id: "3",
        imageLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/animal.jpeg",
        modeleName: "animal",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/animal.glb"),
    DsitantImageAsset(
        id: "3",
        imageLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/papillon.jpeg",
        modeleName: "papillon",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/Papillon%20monarque.glb"),
    DsitantImageAsset(
        id: "3",
        imageLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/souris.jpeg",
        modeleName: "souris",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/Souris.glb"),
    DsitantImageAsset(
        id: "3",
        imageLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/snail.jpeg",
        modeleName: "snail",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/snail.glb"),
    DsitantImageAsset(
        id: "3",
        imageLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/bee.jpeg",
        modeleName: "bee",
        modelLink:
            "https://github.com/Ahmed2000Github/Models/raw/master/Bee.glb"),
  ];
}
