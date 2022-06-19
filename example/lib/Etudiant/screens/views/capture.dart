import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Capture(),
    );
  }
}
class Capture extends StatefulWidget {
  const Capture({Key key}) : super(key: key);
  @override
  State<Capture> createState() => _MyHomepageState();
}
class _MyHomepageState extends State<Capture> {
  final GlobalKey _key = GlobalKey();
  void _CaptureScreenShot() async{
    //get paint bound of your app screen or the widget which is wrapped with RepaintBoundary.
    RenderRepaintBoundary bound = _key.currentContext.findRenderObject() as RenderRepaintBoundary;
    if(bound.debugNeedsPaint){
      Timer(Duration(seconds: 1),()=>_CaptureScreenShot());
      return null;
    }
    ui.Image image = await bound.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // this will save image screenshot in gallery
    if(byteData != null ){
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
      print(resultsave);
    }
  }
  @override
  Widget build(BuildContext context) {
    //Here i have wrapped whole app screen scaffold widget, to take full screenshot
    return RepaintBoundary(
      key: _key,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color:Colors.blue,width: 220,height: 220,),
              SizedBox(height: 25,),
              ElevatedButton(onPressed: (){
                _CaptureScreenShot(); // Method called to take screenshot on wrapped widget and save it.
              }, child: Text("Capture & Save"))
            ],
          )
        ),
      ),
    );
  }
}