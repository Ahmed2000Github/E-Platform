import 'package:arcore_flutter_plugin_example/Professeur/Views/ScanScreen.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/StartCamera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../backend/Niveau.dart';
import 'globals.dart' as globals;

class GetLevels extends StatefulWidget {
  @override
  _GetLevelsState createState() => _GetLevelsState();
}

class _GetLevelsState extends State<GetLevels> {
  Future<List<Niveau>> niveaus;
  final niveausListKey = GlobalKey<_GetLevelsState>();

  @override
  void initState() {
    super.initState();
    niveaus = getNiveausList();
  }

  Future<List<Niveau>> getNiveausList() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.7:8000/mobile/niveau/"+globals.selectedFiliere));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Niveau> niveaus = items.map<Niveau>((json) {
      return Niveau.fromJson(json);
    }).toList();

    return niveaus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: niveausListKey,
      appBar: AppBar(
        title: Text('Niveau List'),
      ),
      body: Center(
        child: FutureBuilder<List<Niveau>>(
          future: niveaus,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      data.nom_niveau,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartCamera()),
                  );},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
