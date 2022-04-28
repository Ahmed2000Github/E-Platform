import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../models/distant_image_asset.dart';

class MultipleAugmentedImagesPage extends StatefulWidget {
  @override
  _MultipleAugmentedImagesPageState createState() =>
      _MultipleAugmentedImagesPageState();
}

class _MultipleAugmentedImagesPageState
    extends State<MultipleAugmentedImagesPage> {
  ArCoreController arCoreController;
  Map<String, ArCoreAugmentedImage> augmentedImagesMap = Map();
  Map<String, Uint8List> bytesMap = Map();
  List<DsitantImageAsset> distantImages = [
    DsitantImageAsset(
        id: "1",
        imageLink:
        "https://github.com/Ahmed2000Github/Models/blob/master/prova_texture.png?raw=true",
        imageName: "earth_augmented_image",
        modelLink:
        "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/sun/sun.gltf"),
    DsitantImageAsset(
        id: "2",
        imageLink:
        "https://github.com/Ahmed2000Github/Models/blob/master/earth.jpg?raw=true",
        imageName: "prova_texture",
        modelLink:
        "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/earth/earth.gltf"),
  ];
  // ignore: avoid_init_to_null, non_constant_identifier_names
  String NameObject = null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multiple augmented images'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

// creation sde vue AR et chargement des images
  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadMultipleImage();
  }

// chargement des images on utilisant les liens
  loadMultipleImage() async {
    for (var asset in distantImages) {
      final ByteData bytes =
          await NetworkAssetBundle(Uri.parse(asset.imageLink)).load("");
      bytesMap[asset.imageName] = bytes.buffer.asUint8List();
    }
    arCoreController.loadMultipleAugmentedImage(bytesMap: bytesMap);
  }

// evenement de detection de l'image
  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.name)) {
      augmentedImagesMap[augmentedImage.name] = augmentedImage;
      _addModel(augmentedImage);
    }
  }

// ajoute du modele correspondant au image detecter a la scene ou vue AR
  Future _addModel(ArCoreAugmentedImage augmentedImage) async {
    double size = augmentedImage.extentX / 2;
    if (NameObject != null) {
      arCoreController.removeNode(nodeName: NameObject);
      NameObject = null;
    }
    for (var asset in distantImages) {
      if (asset.imageName == augmentedImage.name) {
        NameObject = asset.imageName;
        final node = ArCoreReferenceNode(
            scale: vector.Vector3.all(0.15),
            name: asset.imageName,
            objectUrl: asset.modelLink,
            // objectUrl:'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf',
            // scale: vector.Vector3(size, size, size),
            // position: augmentedImage.centerPose.translation,
            rotation: augmentedImage.centerPose.rotation);

        arCoreController.addArCoreNodeToAugmentedImage(
            node, augmentedImage.index);
      }
    }
  }

  
  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
