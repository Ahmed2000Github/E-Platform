import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/models/etudiant_data.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cours.dart';
import 'chapitre_list.dart';

class CoursList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoursList();
}

class _CoursList extends State<CoursList> {
  Future<List<Cours>> cours;
  EtudiantDataProvider etudiantDataProvider;
  @override
  void initState() {
    cours = fetchUsers();
    this.etudiantDataProvider = EtudiantDataProvider();
    this.etudiantDataProvider.open();
    this.etudiantDataProvider.insert(new EtudiantData(
          id : null,
          coursId: 0,
          chapitreId: 0
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
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
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              iconSize: 40,
              onPressed: () {
                setState(() {
                  cours = fetchUsers();
                });
              },
            ), //IconButton
          ],
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
                      child: Card(
                        child: ListTile(
                            // leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                            title: Center(
                          child: Text(
                            snapshot.data[index].id.toString(),
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

  Future<List<Cours>> fetchUsers() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    return (json.decode(response.body) as List)
        .map((e) => Cours.fromJson(e))
        .toList();
  }

  getItemAndNavigate(int item, BuildContext context) {
    this.etudiantDataProvider.update(new EtudiantData(
          id : 1,
          coursId: item,
          chapitreId: 0
        ));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ChapitresList()),
      (Route<dynamic> route) => false,
    );
  }
}
