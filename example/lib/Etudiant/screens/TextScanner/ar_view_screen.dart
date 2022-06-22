import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/models/utils.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/TextScanner/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:developer' as developer;

class TextArViewScreen extends StatefulWidget {
  final model;

  const TextArViewScreen({Key key, this.model}) : super(key: key);

  @override
  _ArModelScreenState createState() => _ArModelScreenState();
}

class _ArModelScreenState extends State<TextArViewScreen> {
  ArCoreController arCoreController;

  String objectSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Object on plane detected'),
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              child: ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enableTapRecognizer: true,
              ),
            ),
            FlatButton(
                onPressed: () {
                  goBack();
                },
                child: Text("Go Back"))
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addToucano(ArCoreHitTestResult plane) {
    developer.log("here it cooomes:  " + Utils.RootUrl + widget.model);

    final toucanNode = ArCoreReferenceNode(
      //  scale: new vector.Vector3.all(0.00000015),
      scale: vector.Vector3(0.002, 0.002, 0.002),
      position: vector.Vector3(0.0, 0.0, 0.0),
      rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
      name: "Toucano",
      objectUrl: Utils.RootUrl + widget.model,
      // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",

      //  "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/sun/sun.gltf",
    );

    arCoreController.addArCoreNodeWithAnchor(toucanNode);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  void goBack() {
    arCoreController.dispose();
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new ColorPickerScreen()));
  }
}
