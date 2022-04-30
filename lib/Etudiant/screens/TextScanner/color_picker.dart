import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'scan_text.dart';

class ColorPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color mycolor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Color Picker"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
            color: mycolor, //background color of app from color picker

            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text(mycolor.red.toString() +
                  mycolor.green.toString() +
                  mycolor.blue.toString()),
              Text(mycolor.toString().substring(9, 15)),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: mycolor, //default color
                              onColorChanged: (Color color) {
                                //on color picked
                                setState(() {
                                  mycolor = color;
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TextRecognitionWidget(color: [
                                              mycolor.red,
                                              mycolor.green,
                                              mycolor.blue
                                            ])));
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Text("Default Color Picker"),
              ),
            ])));
  }
}
