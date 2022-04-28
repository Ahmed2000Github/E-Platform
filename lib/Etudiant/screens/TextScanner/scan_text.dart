import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';

import 'http_service.dart';
import 'package:clipboard/clipboard.dart';
import 'firebase_ml_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:io'as Io;
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  final uri = Uri.parse('https://text-recog.herokuapp.com/identify');

  @override
  Widget build(BuildContext context) =>
      Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 16),
            ControlsWidget(
              onClickedPickImage: pickImageFromCamera,
              onClickedScanText: scanText,
              onClickedClear: clear,
            ),
            const SizedBox(height: 16),
            /*  TextAreaWidget(
          text: text,
          onClickedCopy: copyToClipboard,
        ),*/
          ],
        ),
      );

  Widget buildImage() =>
      Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.deepOrange),
      );

  Future pickImageFromGallery() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
  }

  Future pickImageFromCamera() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    image=File(file.path);
    Uint8List imagebytes = await image.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes); //convert bytes to base64 string
    developer.log('base64 before:' + base64string);
    print("Send post method");
    var color = [255, 0, 0];
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'color': color,
      'bytes': base64string
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    try {
      Response response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,);
      print(response.statusCode);
      String responseBody = response.body;
      developer.log('base64 after:' + responseBody);
        if (responseBody == null||responseBody.isEmpty)
          return new Container();
        Uint8List bytes = Base64Codec().decode(responseBody);

      } catch (er) {
      print(er.toString());
    }











/*
    setState(() {
      Scaffold(
          body: Container(
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Image.memory(bytes,fit: BoxFit.cover,)),
                  ))));
    });*/
  }

  Future scanText() async {
    showDialog(
      builder: (context) =>
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ), context: context,
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);
    Navigator.of(context).pop();
  }

  void clear() {
    //setImage(null!);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  Widget getImagenBase64(String imagen) {
    const Base64Codec base64 = Base64Codec();
    if (imagen == null) return new Container();
    return Image.memory(
      base64.decode(imagen),
      width: 200,
      fit: BoxFit.fitWidth,

    );
  }
}

