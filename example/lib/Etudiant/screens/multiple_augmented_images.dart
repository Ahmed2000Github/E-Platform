import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../models/distant_image_asset.dart';
import 'cours_list.dart';

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

  // creation et initialisation de la variable qui contient les modeles et leurs images associees
  List<DsitantImageAsset> distantImages = [
    DsitantImageAsset(
        id: "1",
        imageLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/earth.jpg",
        modeleName: "earth_augmented_image",
        modelLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/earth/earth.gltf"),
    DsitantImageAsset(
        id: "2",
        imageLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/Sun.jpg",
        modeleName: "prova_texture",
        modelLink:
            "https://raw.githubusercontent.com/Ahmed2000Github/Models/master/sun/sun.gltf"),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multiple augmented images'),
          leading: IconButton(
            onPressed: (() {
             Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CoursList())
                                ,
                 (Route<dynamic> route) => false,
                                );
                      
            }),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

// creation de vue AR et chargement des images
  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadMultipleImage();
  }

// chargement des images on utilisant les liens
  loadMultipleImage() async {
    for (var asset in distantImages) {
      final ByteData bytes =
          await NetworkAssetBundle(Uri.parse(asset.imageLink)).load("");
      bytesMap[asset.modeleName] = bytes.buffer.asUint8List();
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
    for (var asset in distantImages) {
      if (asset.modeleName == augmentedImage.name) {
        final node = ArCoreReferenceNode(
          scale: vector.Vector3.all(0.15),
          name: asset.modeleName,
          objectUrl: asset.modelLink,
           // scale: vector.Vector3(size, size, size),
          // position: augmentedImage.centerPose.translation,
          // rotation: augmentedImage.centerPose.rotation
        );

        arCoreController.addArCoreNodeToAugmentedImage(
            node, augmentedImage.index);
      }
    }
  }

// lors de click sur le modele il va etre supprimer
  void onTapHandler(String name) {
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
}
