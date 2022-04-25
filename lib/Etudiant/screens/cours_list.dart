import 'dart:convert';

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
  @override
  void initState() {
    cours = fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              Navigator.pop(context);
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
            return  SizedBox(
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChapitresList(itemHolder: item)));
  }
}
