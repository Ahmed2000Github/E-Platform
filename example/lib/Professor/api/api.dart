import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/etudiant.dart';

class EtudiantProvider with ChangeNotifier {
  EtudiantProvider() {
    this.fetchEtudiant();
  }

  List<Etudiant> _etudiants = [];
  List<Etudiant> get etudiants {
    return [..._etudiants];
  }

  fetchEtudiant() async {
    final url = 'http://192.168.88.201:8000/apis/v1/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _etudiants =
          data.map<Etudiant>((json) => Etudiant.fromJson(json)).toList();

    }
  }
}
