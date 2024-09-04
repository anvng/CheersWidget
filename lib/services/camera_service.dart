import 'package:camera/camera.dart';

class CameraService {
  late CameraController _controller;

  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );
    await _controller.initialize();
  }

  Future<XFile> takePicture() async {
    return await _controller.takePicture();
  }

  Future<void> toggleFlash(FlashMode flashMode) async {
    await _controller.setFlashMode(flashMode);
  }

  Future<void> switchCamera(CameraDescription cameraDescription) async {
    await _controller.dispose();
    await initializeCamera(cameraDescription);
  }

  CameraController get controller => _controller;
}
