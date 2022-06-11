import 'dart:convert';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/scanne_list.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/chapitres.dart';
import '../models/etudiant_data.dart';
import '../models/utils.dart';
import 'cours_list.dart';

// statefull classe d'activite liste des chapitres
class ChapitresList extends StatefulWidget {
  ChapitresList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChapitresList();
}

// classe de state d'activite liste des chapitres
class _ChapitresList extends State<ChapitresList> {
  _ChapitresList({Key key});
  Future<List<Chapitres>> chapitres;
  EtudiantDataProvider etudiantDataProvider;
  EtudiantData etudiantData;

  @override
  void initState() {
    initdata();
    super.initState();
  }

  Future<void> initdata() async {
    // initialisation de la variable qui contient les cours
    chapitres = fetchChapitres();
    // initialisation de sqlite provider
    this.etudiantDataProvider = EtudiantDataProvider();
    this.etudiantDataProvider.open();
    etudiantData = await this.etudiantDataProvider.getEtudiantData(1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      // revenire a la page precedente button d'appariel
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CoursList()),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('liste des Chapitres'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              iconSize: 40,
              onPressed: () {
                setState(() {
                  chapitres = fetchChapitres();
                });
              },
            ), //IconButton
          ],
          // revenire a la page precedente button d'activite
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CoursList()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<Chapitres>>(
          future: chapitres,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemBuilder: (BuildContext, index) {
                  return GestureDetector(
                      onTap: () {
                        getItemAndNavigate(snapshot.data[index].id, context);
                      },
                      // les cartes qui contient les chapitres
                      child: Card(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Image.network(
                                snapshot.data[index].image,
                                width: MediaQuery.of(context).size.width * 0.22,
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                              ),
                              ListTile(
                                // leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                                title: Text(snapshot.data[index].libelle),
                                subtitle:
                                    Text(snapshot.data[index].description),
                              ),
                            ],
                          ),
                        ),
                        color: Color.lerp(Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(224, 35, 68, 237), 2),
                      ));
                },
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (200 / 200),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                ),
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

// fonction qui retourne la liste des chapitres correspondant au cours depuis le serveur
  Future<List<Chapitres>> fetchChapitres() async {
    try {
      var response = await http.get(Uri.parse(Utils.RootUrl + 'chapitres'));
      List<Chapitres> liste = (json.decode(response.body) as List)
          .map((e) => Chapitres.fromJson(e))
          .toList();
      return liste;
    } catch (e) {
      _Noconnection(context);
    }
    return null;
  }

// enregistre le id de chapitre et passe l'activite des scanne
  getItemAndNavigate(int item, BuildContext context) {
    this.etudiantDataProvider.update(new EtudiantData(
        id: 1, coursId: etudiantData.coursId, chapitreId: item));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScanneList()),
      (Route<dynamic> route) => false,
    );
  }

  // affichage d'une message si il y'a un erreur
  _Noconnection(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              'Erreur',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text('La connection au serveur est echoue'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ChapitresList()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Ressayer',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Accuiel',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
