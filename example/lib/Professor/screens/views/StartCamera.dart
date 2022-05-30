import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:developer';
import '../../models/Filiere.dart';
import 'globals.dart' as globals;
import 'CameraDetection.dart';

class StartCamera extends StatefulWidget {
  @override
  _StartCameraState createState() => _StartCameraState();
}

class _StartCameraState extends State<StartCamera> {
  Future<List<Filiere>> filieres;
  final filieresListKey = GlobalKey<_StartCameraState>();

  @override
  void initState() {
    super.initState();
    startLive();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraDetection()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: filieresListKey,
      appBar: AppBar(
        title: Text('Live Started'),
      ),
      body: Center(
        child: Text("the camera has started succefuly"),
      ),
    );
  }

  Future<void> startLive() async {
    final url = Uri.parse('http://192.168.1.7:8000/mobile/niveau_Choisi');
    final headers = {"Content-type": "application/json"};
    final json = '{"title": "Hello", "body": "body text", "userId": 1}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }
}
