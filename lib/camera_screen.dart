/*import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras;
  Future<void> CameraScreen() async {
    cameras = await availableCameras();
  }
  //CameraScreen(this.cameras);
  static const String id = 'camera_screen';
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return RotationTransition(
      turns: AlwaysStoppedAnimation(270 / 360),
      child: CameraPreview(controller),
    );
  }
}*/

