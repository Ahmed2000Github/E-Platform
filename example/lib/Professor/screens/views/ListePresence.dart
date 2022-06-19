import 'package:arcore_flutter_plugin_example/Professor/screens/views/ScanScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'globals.dart' as globals;

import 'package:flutter/services.dart';

class ListePresence extends StatefulWidget {
  @override
  _ListePresenceState createState() => _ListePresenceState();
}

class _ListePresenceState extends State<ListePresence> {
  List _items = [];

  @override
  void initState() {
    print("Global data  reda :" + globals.data.toString() + " fin global data");
    globals.visiblepres = true;
    readJson();
    super.initState();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    // final String response = await rootBundle.loadString('assets/presence.json');
    // final data = await json.decode(response);

    setState(() {
      _items = globals.data;
      print("hredi");
      print(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des étudiants présents'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              // leading: Text(_items[index]["path"] +"\n"+ _items[index]["path"]),
                              leading: Column(children: <Widget>[
                                CircleAvatar(
                                  radius: 10.0,
                                  backgroundImage: NetworkImage(
                                      "http://192.168.129.201:8000/emploie/api/get-photo/media/photo.jpg"),
                                  backgroundColor: Colors.transparent,
                                ),
                                CircleAvatar(
                                  child: Icon(Icons.person),
                                  radius: 10,
                                ),
                              ]),
                              title: Text(_items[index]["etudiant"]["user"]
                                  ["username"]),
                              subtitle: Text(
                                  (_items[index]["is_present"]).toString() ==
                                          'false'
                                      ? "Absent(e)"
                                      : "Present(e)"),
                              trailing: IconButton(
                                  onPressed: () {
                                    globals.idtobecorrected =
                                        _items[index]["etudiant"]["id"];
                                    globals.seancetobecorrected =
                                        _items[index]["seance"];
                                    globals.nametobecorrected = _items[index]
                                        ["etudiant"]["user"]["username"];
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanScreen()),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.qr_code,
                                    color: Colors.blue[900],
                                  ))),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
