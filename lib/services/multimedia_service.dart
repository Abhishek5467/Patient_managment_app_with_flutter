import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Capture Image
Future<void> captureImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    print('Image captured: ${imageFile.path}');
    // Save the image path to local storage or associate it with a record
  } else {
    print('No image selected.');
  }
}

// Capture Video
Future<void> captureVideo() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickVideo(source: ImageSource.camera, maxDuration: Duration(seconds: 10));

  if (pickedFile != null) {
    File videoFile = File(pickedFile.path);
    print('Video captured: ${videoFile.path}');
    // Save the video path to local storage or associate it with a record
  } else {
    print('No video selected.');
  }
}
