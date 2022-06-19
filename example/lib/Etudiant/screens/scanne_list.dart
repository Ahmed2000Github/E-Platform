import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/screens/TextScanner/color_picker.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/chapitre_list.dart';
import 'package:arcore_flutter_plugin_example/color.dart';
import 'package:flutter/material.dart';

import '../models/distant_image_asset.dart';
import 'package:http/http.dart' as http;
import '../models/utils.dart';
import 'QrCodeScanner/new_scan_new_qr.dart';
import 'multiple_augmented_images.dart';

// classe represente l'activite de choix de l'option de scan
class ScanneList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanneList();
}

class _ScanneList extends State<ScanneList> {
  // liste des choice de scan avec leur description
  List<ScanChoice> ScanChoices = [
    ScanChoice(
        choiceId: 1,
        title: 'Image augmenté    ',
        description: 'scan d\'image pour afficher modele',
        imagePath: 'assets/images/ar_image.png'),
    ScanChoice(
        choiceId: 2,
        title: 'QR Code augmenté',
        description: 'scan de QR Code pour afficher le modele',
        imagePath: 'assets/images/qrscan.png'),
    ScanChoice(
        choiceId: 3,
        title: 'Texte augmenté    ',
        description: 'scanne du text pour afficher le modele ',
        imagePath: 'assets/images/textscan.png'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Les scannes disponibles'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.download),
                  tooltip: 'dowload',
                  iconSize: 40,
                  // si on a des erreurs de notre serveur
                  onPressed: () {
                    Utils.distantImages = [
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
                  },
                ), //IconButton
              ],
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ChapitresList()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: ChoiceListView(ScanChoices: ScanChoices)));
  }

  // fonction qui retourne la listes des liens des images et les modeles depuis le serveur
  Future<void> fetchImages() async {
    var response = await http.get(Uri.parse(
        Utils.RootUrl + '/cours/api/modeles/' + Utils.chapitreId.toString()));
    List<DsitantImageAsset> liste = (json.decode(response.body) as List)
        .map((e) => DsitantImageAsset.fromJson(e))
        .toList();

    if (liste == null) {
      liste = [
        DsitantImageAsset(
            id: "3",
            imageLink:
                "https://github.com/Ahmed2000Github/Models/raw/master/bee.jpeg",
            modeleName: "bee",
            modelLink:
                "https://github.com/Ahmed2000Github/Models/raw/master/Bee.glb"),
      ];
    }
    Utils.distantImages = liste;
    for (var item in Utils.distantImages) {
      print("daddadd   :" + item.modeleName);
    }
    // setState(() {
    //   distantImages = liste;
    //   for (var item in liste) {
    //     print('the incoming data : ' + item.modelLink);
    //   }
    // });
  }
}

// class represente les choix avec leur details
class ScanChoice {
  String title;
  String description;
  String imagePath;
  int choiceId;

  ScanChoice({this.choiceId, this.title, this.description, this.imagePath});
}

//classe pour convertir la liste des donnees en des composants graphiques
class ChoiceListView extends StatelessWidget {
  List<ScanChoice> ScanChoices = [];

  ChoiceListView({this.ScanChoices});

  List<Widget> _bulidList(BuildContext context) {
    List<Widget> list = [];
    list.add(Container(
        height: 200,
        // color: Color.fromARGB(255, 83, 154, 230),
        child: Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Choisir une \n    Option',
              style: TextStyle(
                  fontFamily: 'Updock',
                  fontSize: 34,
                  letterSpacing: 3.2,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            // SizedBox(width: 48),
            Image.asset('assets/images/select.png', height: 100, width: 100)
          ],
        )));
    for (ScanChoice scanChoice in ScanChoices) {
      list.add(
        Builder(
            builder: (context) => InkWell(
                  onTap: () {
                    switch (scanChoice.choiceId) {
                      case 1:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MultipleAugmentedImagesPage()),
                          (Route<dynamic> route) => false,
                        );
                        break;
                      case 2:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewScanNewQr()),
                          (Route<dynamic> route) => false,
                        );
                        break;
                      case 3:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ColorPickerScreen()),
                          (Route<dynamic> route) => false,
                        );
                        break;
                      default:
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5), //shadow color
                            spreadRadius: 5, // spread radius
                            blurRadius: 7, // shadow blur radius
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                scanChoice.title,
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                scanChoice.description,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                          Image.asset(
                            scanChoice.imagePath,
                            height: 200,
                          ),
                        ],
                      )),
                )),
      );
      list.add(SizedBox(height: MediaQuery.of(context).size.height * 0.05));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StandardColor.color4,
      child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: _bulidList(context)),
    );
  }
}
