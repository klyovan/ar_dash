import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BackFlipAnimationPage extends StatefulWidget {
  @override
  _BackFlipAnimationPageState createState() => _BackFlipAnimationPageState();
}

class _BackFlipAnimationPageState extends State<BackFlipAnimationPage> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Back Flip'), backgroundColor: Colors.blueGrey),
        body: ARKitSceneView(
          debug: true,
          showFeaturePoints: true,
          planeDetection: ARPlaneDetection.horizontal,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is! ARKitPlaneAnchor) {
      return;
    }
    _addPlane(arkitController, anchor);
  }

  void _addPlane(ARKitController? controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller?.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/backflip.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.002, 0.002, 0.002),
    );
    controller?.add(node!, parentNodeName: anchor.nodeName);
  }
}
