import 'package:arcore_flutter_plugin_example/Professeur/Views/GetLevels.dart';
import 'package:arcore_flutter_plugin_example/Professeur/Views/ScanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../backend/Filiere.dart';
import 'globals.dart' as globals;

class LunchCamera extends StatefulWidget {
  @override
  _LunchCameraState createState() => _LunchCameraState();
}

class _LunchCameraState extends State<LunchCamera> {
  Future<List<Filiere>> filieres;
  final filieresListKey = GlobalKey<_LunchCameraState>();

  @override
  void initState() {
    super.initState();
    filieres = getFilieresList();
  }

  Future<List<Filiere>> getFilieresList() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.7:8000/mobile/filieres"));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Filiere> filieres = items.map<Filiere>((json) {
      return Filiere.fromJson(json);
    }).toList();

    return filieres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: filieresListKey,
      appBar: AppBar(
        title: Text('Filiere List'),
      ),
      body: Center(
        child: FutureBuilder<List<Filiere>>(
          future: filieres,
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
                      data.nom_filiere,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      globals.selectedFiliere = data.nom_filiere;
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetLevels()),
                      );
                    },
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
