import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'search.dart';
import 'overlay_maker.dart';
import 'scanner_utils.dart';
import 'home_ui.dart';

class HomeCameraView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeCameraViewState();
}

class _HomeCameraViewState extends State<HomeCameraView> {
  dynamic _scanResults;
  CameraController _camera;
  Detector _currentDetector = Detector.text;
  bool _isDetecting = false;
  int _frameCounter = 0;
  CameraLensDirection _direction = CameraLensDirection.back;

  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;
      _frameCounter++;

      if (_frameCounter != 1) {
        if (_frameCounter == 5) {
          _frameCounter = 0;
        }
        return;
      }
      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _recognizer.processImage,
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          if (_currentDetector != null) setState(() => _scanResults = results);
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Widget _buildARResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    switch (_currentDetector) {
      default:
        if (_scanResults is! VisionText) return noResultsText;
        return CustomPaint(
            painter: TextDetectorPainter(imageSize, _scanResults));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isCameraInitialised = _camera == null;

    Widget loadingScreen = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            width: 200.0,
            image: AssetImage('assets/images/logo.png'),
          )
        ],
      ),
    );

    Widget homePage = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CameraPreview(_camera),
        _buildARResults(),
        HomeButtonsRow(),
        SearchBar(),
      ],
    );

    return Scaffold(
      body: Container(child: _isCameraInitialised ? loadingScreen : homePage),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _recognizer.close();
    });

    _currentDetector = null;
    super.dispose();
  }
}
