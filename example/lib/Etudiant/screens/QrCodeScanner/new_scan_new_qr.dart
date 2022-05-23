import 'dart:async';
import 'dart:io' show Platform;

import 'package:arcore_flutter_plugin_example/Etudiant/screens/scanne_list.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ar_screen.dart';

class NewScanNewQr extends StatefulWidget {
  const NewScanNewQr({Key key}) : super(key: key);

  @override
  _AppStateQr createState() => _AppStateQr();
}

class _AppStateQr extends State<NewScanNewQr> {
  ScanResult scanResult;
  String scanResultat;

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // _scan(context);
    final scanResult = this.scanResult;
    final scanResultat = this.scanResultat;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScanneList()),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Qr Code Scanner'),
             leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ScanneList()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          ),
          body: Column(
            children: [
              if (scanResult == null)
                Text("Vous devez scanner un qr de vos cours"),
              Center(
                  child: Column(

                children: [

                  Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
                  FlatButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () => _scanQr(context),
                    child: Text(
                      "Scan Qr Code",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ],
              ))
            ],
          )),
    );
  }

  Future<void> _scanQr(BuildContext context) async {
    String modelUrl;
    try {
      var result = await BarcodeScanner.scan(
        options: ScanOptions(
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      if (result.rawContent
          .contains('https://raw.githubusercontent.com/ismail-ERK/models-ar')) {
        setState(() => scanResultat = result.rawContent);
        modelUrl = result.rawContent;
        Navigator.push(
            context,
            // new MaterialPageRoute(builder: (context) => new RemoteObject(modelUrl: label,)));
            new MaterialPageRoute(
                builder: (context) => new ArModelScreen(modelUrl: modelUrl)));
      } else {
        setState(() => scanResultat = "none");
      }
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}

Widget flatButton(BuildContext context, String text, Widget widget) {
  return FlatButton(
    padding: EdgeInsets.all(15.0),
    onPressed: () async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget));
    },
    child: Text(
      text,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue, width: 3.0),
        borderRadius: BorderRadius.circular(20.0)),
  );
}
