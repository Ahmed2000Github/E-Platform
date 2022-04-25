import 'dart:convert';

import 'package:arcore_flutter_plugin_example/screens/scanne_list.dart';
import 'package:arcore_flutter_plugin_example/screens/start_activity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/chapitres.dart';

class ChapitresList extends StatefulWidget {
  ChapitresList({Key key, @required this.itemHolder})
      : super(key: key);
  final int itemHolder;
  @override
  State<StatefulWidget> createState() =>
      _ChapitresList(itemHolder: itemHolder);
}

class _ChapitresList extends State<ChapitresList> {
  _ChapitresList({Key key, @required this.itemHolder});
  final int itemHolder;
  Future<List<Chapitres>> chapitres;
  @override
  void initState() {
    print(itemHolder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<Chapitres>>(
          future: fetchUsers(),
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
                      title: Text(snapshot.data[index].titre),
                      subtitle: Text("This is subtitle"),
                    ),
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

  Future<List<Chapitres>> fetchUsers() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    return (json.decode(response.body) as List)
        .map((e) => Chapitres.fromJson(e))
        .toList();
  }

  getItemAndNavigate(int item, BuildContext context) {
   
    Navigator.push(context,MaterialPageRoute(builder: (context) => ScanneList()));
        
  }
}
