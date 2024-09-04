import 'package:cheers_widget/models/photo.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CapturePhotoScreen extends StatefulWidget {
  const CapturePhotoScreen({super.key});

  @override
  _CapturePhotoScreenState createState() => _CapturePhotoScreenState();
}

class _CapturePhotoScreenState extends State<CapturePhotoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool _isFlashOn = false;
  CameraDescription? _selectedCamera;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

      _selectedCamera = cameras[0]; // Default to the first camera

      _controller = CameraController(
        _selectedCamera!,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing cameras: $e');
      }
      // Show an error message or redirect user as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Camera Error'),
          content: Text('Failed to initialize cameras: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final timestamp = DateTime.now();

      await DatabaseHelper.instance.insertPhoto(Photo(
        path: image.path,
        timestamp: timestamp.toIso8601String(),
      ));

      Navigator.pop(context);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    _controller.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  void _switchCamera() {
    if (cameras.isNotEmpty) {
      setState(() {
        final newIndex =
            (cameras.indexOf(_selectedCamera!) + 1) % cameras.length;
        _selectedCamera = cameras[newIndex];

        _controller = CameraController(
          _selectedCamera!,
          ResolutionPreset.high,
        );
        _initializeControllerFuture = _controller.initialize();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Photo'),
        actions: [
          IconButton(
            icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: _toggleFlash,
          ),
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
