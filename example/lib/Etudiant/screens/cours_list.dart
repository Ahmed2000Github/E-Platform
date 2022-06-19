import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/models/etudiant_data.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cours.dart';
import '../models/utils.dart';
import 'chapitre_list.dart';

// statefull classe d'activite liste des cours
class CoursList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoursList();
}

// classe de state d'activite liste des cours
class _CoursList extends State<CoursList> {
  Future<List<Cours>> cours;
  EtudiantDataProvider etudiantDataProvider;
  @override
  void initState() {
    initdata();
    super.initState();
  }

  Future<void> initdata() async {
    // initialisation de la variable qui contient les cours
    cours = fetchCours();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      // revenire a la page precedente button d'appariel
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('liste des Cours'),
          actions: <Widget>[
            // rechargement de la liste des cours
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              iconSize: 40,
              onPressed: () {
                setState(() {
                  cours = fetchCours();
                });
              },
            ), //IconButton
          ],
          // revenire a la page precedente button d'activite
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<Cours>>(
          future: cours,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext, index) {
                  return GestureDetector(
                      onTap: () {
                        getItemAndNavigate(snapshot.data[index].id, context);
                      },
                      // les cartes qui contient les titres des cours
                      child: Card(
                        child: ListTile(
                            // leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                            title: Center(
                          child: Text(
                            snapshot.data[index].libelle_module,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        )),
                        color: Color.lerp(Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 44, 77, 240), 2),
                      ));
                },
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // spinner apparetre lorsque le resultat de REST pas encore arrive
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

// fonction qui retourne la listes des cours depuis le serveur
  Future<List<Cours>> fetchCours() async {
    try {
      var response = await http.get(
          Uri.parse(Utils.RootUrl + '/modules/liste_ElementModule'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + Utils.token,
          });
      List<Cours> liste = (json.decode(response.body) as List)
          .map((e) => Cours.fromJson(e))
          .toList();
      return liste;
    } catch (e) {
      _Noconnection(context);
    }
    return null;
  }

// enregistre le id de cours et passe l'activite des chapitres
  getItemAndNavigate(int item, BuildContext context) {
    Utils.coursId = item.toString();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ChapitresList()),
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
                    MaterialPageRoute(builder: (context) => CoursList()),
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
