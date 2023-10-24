// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class DashAnimationPage extends StatefulWidget {
  @override
  _DashAnimationPageState createState() => _DashAnimationPageState();
}

class _DashAnimationPageState extends State<DashAnimationPage> {
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
          title: const Text('Dash'),
          backgroundColor: Colors.blue,
        ),
        body: ARKitSceneView(
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
      url: 'models.scnassets/breake.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
    controller?.add(node!, parentNodeName: anchor.nodeName);
  }
}
