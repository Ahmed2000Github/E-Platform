import 'dart:convert';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/scanne_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/chapitres.dart';
import '../models/etudiant_data.dart';
import 'cours_list.dart';

class ChapitresList extends StatefulWidget {
  ChapitresList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChapitresList();
}

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
    this.etudiantDataProvider = EtudiantDataProvider();
    this.etudiantDataProvider.open();
    etudiantData = await this.etudiantDataProvider.getEtudiantData(1);
    print(etudiantData.coursId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WillPopScope(
      // ignore: missing_return
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
              onPressed: () {},
            ), //IconButton
          ],
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
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemBuilder: (BuildContext, index) {
                  return GestureDetector(
                      onTap: () {
                        getItemAndNavigate(snapshot.data[index].id, context);
                      },
                      child: Card(
                        child:Center(
                          child: Column(children: [
                          SizedBox(height: 8,),
                         Image.network(  'https://picsum.photos/250?image=9', 
                         width: 100,),
                         ListTile(
                          // leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                          title: Text('chapitre'),
                          subtitle: Text("This is subtitle"),
                        ),
                        ],),
                        )
                        ,
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
    ));
  }

  Future<List<Chapitres>> fetchUsers() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    return (json.decode(response.body) as List)
        .map((e) => Chapitres.fromJson(e))
        .toList();
  }

  getItemAndNavigate(int item, BuildContext context) {
    this.etudiantDataProvider.update(new EtudiantData(id: 1,coursId: etudiantData.coursId, chapitreId: item));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScanneList()),
      (Route<dynamic> route) => false,
    );
  }
}
