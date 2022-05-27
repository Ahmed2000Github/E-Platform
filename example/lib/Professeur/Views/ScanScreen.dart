import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:dropdown_search/dropdown_search.dart';
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


  // // Fetch content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/etablissements.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["items"];
  //   });
  // }

  var qrstr = '';
  var selectedEtablissment="FSSM";
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Scanning QR Code'),
        ),
        body: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/qrcode.png',
                  height: 100,
                  width: 50,
                ),
                Text(
                  'Cliquer ici pour scanner les utilisateurs',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                ElevatedButton(onPressed: scanQr, child: Text(('Scanner'))),
               
     
                
                Text(
                  qrstr,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                // SizedBox(height: height,width: width,
                Card(
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/hishem.png",
                    ),
                  ),
                  title: Text("Hicham Marouni"),
                  subtitle: Text("IRISI 2\n E45512"),
                  isThreeLine: true,
                  trailing: Icon(Icons.delete),
                  contentPadding: const EdgeInsets.all(4),
                )),
              ]),
        ));
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;
        });
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }

}
