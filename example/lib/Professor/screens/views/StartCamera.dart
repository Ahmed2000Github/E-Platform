import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:developer';
import '../../models/Filiere.dart';
import 'globals.dart' as globals;
import 'CameraDetection.dart';
import 'package:path_provider/path_provider.dart';
import 'ListePresence.dart';
import 'globals.dart' as globals;
import '../../../Etudiant/models/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StartCamera extends StatefulWidget {
  @override
  _StartCameraState createState() => _StartCameraState();
}

class _StartCameraState extends State<StartCamera> {
  @override
  void initState() {
    super.initState();
    startLive();
    Future.delayed(Duration(seconds: 25), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListePresence()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Live Started'),
          backgroundColor: Colors.blue[900],
        ),
        // body: Center(
        //   //ZIDI SOINNER
        //   child: Text("please wait until the camera finishes"),
        // ),

        body:  Center(
          child: SpinKitFadingGrid(
            color: Colors.blue.shade900,
          )
             ),
        
        );
  }

  Future<void> startLive() async {
    final url = Uri.parse(Utils.RootUrl + '/face-recognition/mobile/salle');
    final headers = {"Content-type": "application/json"};
    final jsonm = '{"title": "Hello", "body":"' +
        globals.salleId.toString() +
        ''
            '", "userId": 1}';
    final response = await post(url, headers: headers, body: jsonm);
    print('Status code: ${response.statusCode}');
    print('Status code: ${response.body}');
    globals.data = json.decode(response.body) as List;
    // print(data);
  }

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/fichierpres.json');

    print(file.path);
    // await file.writeAsString(text);
  }
}
