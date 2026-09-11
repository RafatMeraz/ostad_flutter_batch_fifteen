import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({super.key});

  @override
  State<FaceDetectionScreen> createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  File? _imageFile;
  ui.Image? _uiImage;
  List<Face> _faces = [];
  bool _isProcessing = false;

  final _picker = ImagePicker();
  final _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableClassification: false,
    ),
  );

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  Future<void> _pickAndDetect() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _isProcessing = true;
      _faces = [];
      _uiImage = null;
    });

    final file = File(picked.path);

    // Decode to ui.Image for painting
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    // Run ML Kit face detection
    final inputImage = InputImage.fromFile(file);
    final faces = await _faceDetector.processImage(inputImage);

    setState(() {
      _imageFile = file;
      _uiImage = frame.image;
      _faces = faces;
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Detection')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _isProcessing
                  ? const CircularProgressIndicator()
                  : _uiImage != null
                      ? CustomPaint(
                          painter: _FacePainter(
                            image: _uiImage!,
                            faces: _faces,
                          ),
                          child: const SizedBox.expand(),
                        )
                      : const Text('Pick an image to detect faces'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_faces.isNotEmpty)
                  Text(
                    '${_faces.length} face${_faces.length > 1 ? 's' : ''} detected',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _isProcessing ? null : _pickAndDetect,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  const _FacePainter({required this.image, required this.faces});

  @override
  void paint(Canvas canvas, Size size) {
    // Scale image to fit canvas
    final scaleX = size.width / image.width;
    final scaleY = size.height / image.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    final offsetX = (size.width - image.width * scale) / 2;
    final offsetY = (size.height - image.height * scale) / 2;

    final dst = Rect.fromLTWH(
      offsetX,
      offsetY,
      image.width * scale,
      image.height * scale,
    );

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      dst,
      Paint(),
    );

    final boxPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final face in faces) {
      final r = face.boundingBox;
      final scaled = Rect.fromLTRB(
        r.left * scale + offsetX,
        r.top * scale + offsetY,
        r.right * scale + offsetX,
        r.bottom * scale + offsetY,
      );
      canvas.drawRect(scaled, boxPaint);
    }
  }

  @override
  bool shouldRepaint(_FacePainter old) =>
      old.image != image || old.faces != faces;
}