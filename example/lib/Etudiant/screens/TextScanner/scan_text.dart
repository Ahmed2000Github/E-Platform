import 'dart:convert';
import 'dart:typed_data';
import 'package:arcore_flutter_plugin_example/Etudiant/models/utils.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/TextScanner/ar_view_screen.dart';
import 'package:http/http.dart';

import 'firebase_ml_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;
import 'dart:io';
import 'controls_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TextRecognitionWidget extends StatefulWidget {
  final color;
  const TextRecognitionWidget({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  File filteredImage;
  var modelsList = [];
  bool modelsFound = false;
  bool isFiltering = false;
  final color_uri = Uri.parse('https://text-recog.herokuapp.com/identify');
  final models_uri = Uri.parse(Utils.RootUrl + "/cours/getTextTraitement");

  @override
  Widget build(BuildContext context) => Expanded(
        child: isFiltering
            ? Center(
                child: SpinKitRotatingCircle(
                  color: Color.fromARGB(255, 16, 151, 255),
                  size: 50.0,
                ),
              )
            : Column(
                children: [
                  Expanded(child: buildImage()),
                  const SizedBox(height: 16),
                  ControlsWidget(
                    onClickedPickImage: pickImageFromGallery,
                    onClickedTakeImage: pickImageFromCamera,
                  ),
                  const SizedBox(width: 7),
                  image != null
                      ? ElevatedButton(
                          onPressed: clear,
                          child: Text('Clear'),
                        )
                      : const SizedBox(width: 1),
                  filteredImage != null
                      ? ElevatedButton(
                          onPressed: scanText,
                          child: Text(
                            'Scan For Text',
                            style:
                                TextStyle(fontFamily: 'OoohBaby', fontSize: 14),
                          ),
                        )
                      : SizedBox(
                          width: 8,
                        ),
                ],
              ),
      );

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.deepOrange),
      );

  //launch the camera to take a pic
  Future pickImageFromCamera() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);

    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);

    //compress the image, we have to work with a standard height and width
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 80,
        targetWidth: 600,
        targetHeight: (properties.height * 600 / properties.width).round());

    //get the new image and set the state
    final newImage = File(compressedFile.path);
    setImage(newImage);
    filterImageInServer(newImage);
  }

  //use image picker to get an image from gallery
  Future pickImageFromGallery() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);

    //compress the image, we have to work with a standard height and width
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 80,
        targetWidth: 600,
        targetHeight: (properties.height * 600 / properties.width).round());

    //set the state and call on the server to filter the image
    final newImage = File(compressedFile.path);
    setImage(newImage);
    filterImageInServer(newImage);
  }

  Future filterImageInServer(File imageToBeFiltered) async {
    setIsFiltering(true);
    //convert image file to bytes
    Uint8List imagebytes = await imageToBeFiltered.readAsBytes();
    //convert bytes to base64 string
    String base64string = base64.encode(imagebytes);

    //prepare the request data

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'color': widget.color, 'bytes': base64string};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    try {
      print("Sending post method");
      Response response = await post(
        color_uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      setIsFiltering(false);
      print("getting response with status: " + response.statusCode.toString());

      //decode the response and get the 64base image
      var jsonResponse = jsonDecode(response.body);
      String img64 = jsonResponse['response'];

      //image base64 ready : je commence ici outhouna zakaria
      if (img64 == null || img64.isEmpty)
        print("img is null or empty ");
      else {
        final decodedBytes = base64Decode(img64);
        final appDir = await getTemporaryDirectory();
        File file = File('${appDir.path}/img.jpg');
        await file.writeAsBytes(decodedBytes);
        setIsFiltering(false);
        setFilteredImage(File(file.path));
      }
    } catch (er) {
      print(er.toString());
    }
  }

  Future scanText() async {
    final String text = await FirebaseMLApi.recogniseText(image);

    //print text to console
    developer.log("here it cooomes:  " + text);
    setText(text);

    //Prpare the text

    print(text);
    fetchModels(Utils.chapitreId, text);
    //here we need to show a loading spinner with the text found from mlkit
  }

  void clear() {
    setImage(null);
    setFilteredImage(null);
    setText('');
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setFilteredImage(File newImage) {
    setState(() {
      filteredImage = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  void setModelsList(newList) {
    setState(() {
      modelsList = newList;
    });
  }

  void setIsFiltering(boolean) {
    setState(() {
      isFiltering = boolean;
    });
  }

  void setModelsFound(boolean) {
    setState(() {
      modelsFound = boolean;
    });
  }

  Future fetchModels(String id, String text_param) async {
    //prepare the request data
    String words = text_param
        .split(
            RegExp([" ", ";", ",", ".", "+", "-"].map(RegExp.escape).join('|')))
        .join(",");
    developer.log("splited:  " + words);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'chapitre_id': id, 'text': words.trim()};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    try {
      print("Sending post method");
      Response response = await post(
        models_uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      print("getting response with status: " + response.statusCode.toString());

      if (response.statusCode == 404) {
        print("Model Not Found !");
      } else {
        //decode the response and get the 64base image
        var jsonResponse = jsonDecode(response.body);
        String model_img = jsonResponse['path_file'];

        developer.log("here it cooomes:  " + model_img);

        //fetch 3d models links from backend
        final fetchedList = [
          model_img,
        ];

        //change the state
        setModelsList(fetchedList);
        setModelsFound(true);
      }
      if (modelsFound) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new TextArViewScreen(model: modelsList[0])));
      }
    } catch (er) {
      print(er.toString());
    }
  }
}
