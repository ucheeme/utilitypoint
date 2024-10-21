import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraOverlayScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraOverlayScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraOverlayScreenState createState() => _CameraOverlayScreenState();
}

class _CameraOverlayScreenState extends State<CameraOverlayScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _lastCapturedImagePath;
  bool isProcessing = false;
  final double overlayWidthFactor = 0.8; // Percentage of screen width
  final double overlayHeightFactor = 0.6; // Percentage of screen height

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

  Future<void> _takePicture() async {
    try {
      if (!isProcessing) {
        setState(() {
          isProcessing = true;
        });

        // Ensure that the camera is initialized before taking a picture
        await _initializeControllerFuture;

        // Capture the picture
        XFile picture = await _controller.takePicture();

        // Decode the image to manipulate it
        img.Image? originalImage =
        img.decodeImage(await File(picture.path).readAsBytes());

        if (originalImage != null) {
          // Get the screen size and calculate the crop area
          final size = MediaQuery.of(context).size;
          final cropX = (size.width * (1 - overlayWidthFactor) ).toInt();
          final cropY = (size.height * (1 - overlayHeightFactor) ).toInt();
          final cropWidth = (size.width * overlayWidthFactor).toInt();
          final cropHeight = (size.height * overlayHeightFactor).toInt();

          // Crop the image to the rectangular overlay area
          img.Image croppedImage = img.copyCrop(
              originalImage, cropX, cropY, cropWidth, cropHeight);

          // Save the cropped image to temporary storage
          final tempDir = await getTemporaryDirectory();
          final croppedImagePath = '${tempDir.path}/cropped_image.png';
          File(croppedImagePath).writeAsBytesSync(img.encodePng(croppedImage));

          setState(() {
            _lastCapturedImagePath = croppedImagePath; // Save the captured image path
          });

          // Navigate to the new screen with the cropped image
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DisplayPictureScreen(imagePath: croppedImagePath),
          ));
        }

        setState(() {
          isProcessing = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                // Positioned.fill(
                //   child: Stack(
                //     children: [
                //       BackdropFilter(
                //         filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                //         child: Container(
                //           color: Colors.black.withOpacity(0.5), // Darken background
                //         ),
                //       ),
                //       RectangularOverlayPainter(), // Draw transparent rectangle
                //     ],
                //   ),
                // ),
                CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: OverlayPainter(),
                ),
                if (_lastCapturedImagePath != null)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DisplayPictureScreen(imagePath: _lastCapturedImagePath!))),
                      child: Image.file(
                        File(_lastCapturedImagePath!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _takePicture(),
                      child: Text('Capture'),
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

class RectangularOverlayPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RectangularOverlayPainter(),
      child: Container(),
    );
  }
}

class _RectangularOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rectWidth = size.width * 0.8;
    final rectHeight = size.height * 0.6;

    final overlayRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: rectWidth,
      height: rectHeight,
    );

    final outerRect = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerRect = Path()..addRRect(RRect.fromRectAndRadius(overlayRect, Radius.circular(20)));

    // Subtract the innerRect (transparent) from the outerRect
    final blurPaint = Paint()..color = Colors.black.withOpacity(0.5);
    canvas.drawPath(Path.combine(PathOperation.difference, outerRect, innerRect), blurPaint);

    // Draw the border around the transparent rectangle
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRRect(RRect.fromRectAndRadius(overlayRect, Radius.circular(20)), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);


  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  String imagePath ="";
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
     setState(() {
       imagePath =widget.imagePath;
     });
   });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captured Image')),
      body: Center(
        child: Image.file(File(imagePath)), // Display the cropped image
      ),
    );
  }
}


class OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.7) // Grey color with some transparency
      ..style = PaintingStyle.fill;

    // Draw the grey overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Define the transparent rectangle's size and position
    double rectWidth = 200;
    double rectHeight = 300;
    double left = (size.width - rectWidth) / 2;
    double top = (size.height - rectHeight) / 2;

    // Draw the transparent rectangle by clearing the area
    paint.blendMode = BlendMode.clear;
    canvas.drawRect(Rect.fromLTWH(left, top, rectWidth, rectHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}