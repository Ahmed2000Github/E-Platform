import 'package:arcore_flutter_plugin_example/Professor/screens/views/ListePresence.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'globals.dart' as globals;

List _etudiant = globals.data;
List _etablissements = [
  {
    "id": "1",
    'nom': 'FSTG',
    "adresse": "GUELIZ 1",
    "telephone": "0610203040",
    "niveau": "E",
    "website": "E",
    "email": "fstg@gmail.com",
    "logo": "E"
  },
  {
    "id": "2",
    'nom': 'ENSA',
    "adresse": "GUELIZ 2",
    "telephone": "0610203050",
    "niveau": "R",
    "website": "R",
    "email": "ensa@gmail.com",
    "logo": "R"
  }
];

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qrstr = '';
  var selectedEtablissment = "FSSM";
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Scanning QR Code'),
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/prof/qrcode.png',
                  height: 100,
                  width: 50,
                ),
                Text(
                  'Cliquer ici pour scanner un étudiant',
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
                ElevatedButton(onPressed: scanQr, child: Text(('Scanner'))),

                //Condition

                qrstr == ''
                    ? Text("Aucun étudiant n'est scanné")
                    : Card(
                        child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/prof/user.png",
                          ),
                        ),
                        title: Text(qrstr),
                        subtitle: Column(
                          children: <Widget>[
                                const SizedBox(
                                width: 50,
                                height: 30,
                              ),
                              FlatButton(child: Text('Valider la presence',style: TextStyle(color: Colors.white),), onPressed: () {},color: Colors.blue)
                            ],),
                        isThreeLine: true,
                        // trailing: Icon(Icons.check),
                        contentPadding: const EdgeInsets.all(4),
                      ),
                      
                      ),
                      
              ]),
        ));
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        setState(() {
          var nom = value.split(';')[2];
          var prenom = value.split(';')[1];
          var salle = value.split(';')[3];
          globals.scannedStudent = nom;
          qrstr =
              "nom : " + nom + "\n prenom : " + prenom + " \n salle : " + salle;
        });
       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Présence validé pour : " + globals.scannedStudent),
        ));
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }
}
