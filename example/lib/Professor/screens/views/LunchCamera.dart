import 'package:arcore_flutter_plugin_example/Professor/screens/views/StartCamera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../../models/Salle.dart';
import 'GetLevels.dart';
import 'globals.dart' as globals;

class LunchCamera extends StatefulWidget {
  @override
  _LunchCameraState createState() => _LunchCameraState();
}

class _LunchCameraState extends State<LunchCamera> {
  Future<List<Salle>> salles;
  final sallesListKey = GlobalKey<_LunchCameraState>();

  @override
  void initState() {
    super.initState();
    salles = getSallesList();
  }

  Future<List<Salle>> getSallesList() async {
    final response = await http.get(
        Uri.parse("http://192.168.88.201:8000/face-recognition/mobile/salles"));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Salle> salles = items.map<Salle>((json) {
      return Salle.fromJson(json);
    }).toList();
    return salles;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sallesListKey,
      appBar: AppBar(
        title: Text('Liste des salles'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: FutureBuilder<List<Salle>>(
          future: salles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                print(data.disponible);
                return Card(
                  child: ListTile(
                    leading: Icon(data.disponible == false
                        ? Icons.no_meeting_room
                        : Icons.meeting_room),
                    title: Text(
                      data.disponible == false
                          ? "Numéro Salle :" +
                              data.nom_salle +
                              "\n Disponibilité : Non Disponible"
                          : "Numéro Salle :" +
                              data.nom_salle +
                              "\n Disponibilité : Disponible",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      globals.selectedSalle = data.nom_salle;
                      globals.salleId = data.id;
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StartCamera()),
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
