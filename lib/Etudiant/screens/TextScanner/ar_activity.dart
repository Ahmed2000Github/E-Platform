import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AugmentedTextScreen extends StatefulWidget {
  @override
  _AugmentedTextScreenState createState() => _AugmentedTextScreenState();
}

class _AugmentedTextScreenState extends State<AugmentedTextScreen> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Augmented Text'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  Future _addModelTextAugmented(ArCoreHitTestResult plane) {
    final toucanNode = ArCoreReferenceNode(
        name: "Toucano",
        objectUrl:

            // "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/bush.gltf",

            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
        position: plane.pose.translation,
        rotation: plane.pose.rotation);

    arCoreController.addArCoreNodeWithAnchor(toucanNode);
  }

  //  "https://github.com/Ahmed2000Github/spring-react/blob/modele/uploads_files_2894278_Robot.glb",
  //   final node = ArCoreReferenceNode(
  //       objectUrl:
  //           'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf');

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;

    _addModelTextAugmented(hit);
  }
}
