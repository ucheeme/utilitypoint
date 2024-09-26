import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:utilitypoint/utils/myCustomCamera/rectangularOverlay.dart';

import 'circularOverlay.dart';

class CameraOverlayScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraOverlayScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraOverlayScreenState createState() => _CameraOverlayScreenState();
}

class _CameraOverlayScreenState extends State<CameraOverlayScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isCircularOverlay = true; // Controls between circular and rectangular overlay
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

   _takePicture()  {
    try {
      // Check brightness before taking picture
      if (!isProcessing) {
        setState(() {
          isProcessing = true;
        });

           _controller.startImageStream((image)  async {
          if (await isBrightEnough(image)) {
            _controller.stopImageStream();

            // If bright enough, take a picture
            XFile picture = await _controller.takePicture();
            img.Image image = img.decodeImage(await picture.readAsBytes())!;

            // Check if image is blurry
            if (await isImageBlurry(image)) {
              // Notify the user that the image is blurry
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Image is blurry! Please retake.'),
              ));
            } else {
              // If not blurry, save the image
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Image captured successfully!'),
              ));
            }
          }
          else {
            // Notify the user to move to a brighter place
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please move to a brighter location.'),
            ));
          }

          setState(() {
            isProcessing = false;
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera with Overlay'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                if (isCircularOverlay)
                  CircularOverlayPainter()  // For selfie
                else
                  RectangularOverlayPainter(),  // For other objects
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _takePicture(),
                          child: Text('Capture'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isCircularOverlay = !isCircularOverlay;
                            });
                          },
                          child: Text('Switch to ${isCircularOverlay ? 'Rectangle' : 'Circle'} Overlay'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<bool> isBrightEnough(CameraImage cameraImage) async {
  // Convert the CameraImage to an image from the `image` package
  final img.Image? image = convertYUV420ToImage(cameraImage);

  if (image == null) return false;

  int totalBrightness = 0;
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      final pixel = image.getPixel(x, y);
      final r = img.getRed(pixel);
      final g = img.getGreen(pixel);
      final b = img.getBlue(pixel);
      totalBrightness += (r + g + b) ~/ 3;
    }
  }

  double averageBrightness = totalBrightness / (image.width * image.height);
  return averageBrightness > 80; // You can adjust this threshold
}

// Helper function to convert YUV to RGB
img.Image? convertYUV420ToImage(CameraImage cameraImage) {
  // Custom conversion logic (depending on the CameraImage format)
  // Implement the YUV to RGB conversion
  return null; // Replace with actual implementation
}


Future<bool> isImageBlurry(img.Image image) async {
  final laplacian = calculateLaplacian(image);
  final variance = laplacian.fold<double>(0, (sum, value) => sum + value * value) / laplacian.length;
  return variance < 100;  // Adjust the threshold as needed
}

// Implement a function to calculate the Laplacian of the image
List<int> calculateLaplacian(img.Image image) {
  final List<int> laplacian = [];
  for (int x = 1; x < image.width - 1; x++) {
    for (int y = 1; y < image.height - 1; y++) {
      final currentPixel = image.getPixel(x, y);
      final surroundingPixels = [
        image.getPixel(x - 1, y), image.getPixel(x + 1, y),
        image.getPixel(x, y - 1), image.getPixel(x, y + 1),
      ];
      final laplacianValue = surroundingPixels.fold<int>(
          0, (sum, pixel) => sum + (currentPixel - pixel).abs());
      laplacian.add(laplacianValue);
    }
  }
  return laplacian;
}

