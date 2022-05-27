import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class CameraDetection extends StatefulWidget {
  @override
  _CameraDetectionState createState() => _CameraDetectionState();
}

class _CameraDetectionState extends State<CameraDetection> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action:
            SnackBarAction(label: 'X', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  ScrollController scrollController = new ScrollController();
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/etudiants.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["etudiants"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste des étudiants présents'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Liste des étudiants présents"),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: (_items == null) ? 0 : _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "${_items[index]['photo_detect']}"),
                                        radius: 40,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "${_items[index]['avatar']}"),
                                        radius: 40,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      
                                      Text(
                                          "${_items[index]['nom']} ${_items[index]['prenom']}",
                                          style: TextStyle(
                                            fontSize: 8,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            _showToast(context,
                                                "présence valider à ${_items[index]['nom']} ${_items[index]['prenom']}");
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.green[900],
                                          )),
                                      IconButton(
                                          onPressed: () {
                      //                       Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ScanScreen()),
                      // );
                                          },
                                          icon: Icon(
                                            Icons.qr_code,
                                            color: Colors.red[900],
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      })),
            
            ],
          ),
        ));
  }
}
