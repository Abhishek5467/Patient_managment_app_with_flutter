import 'package:flutter/material.dart';
import '../services/multimedia_service.dart';

class MultimediaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Multimedia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: captureImage,
              child: Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: captureVideo,
              child: Text('Capture Video'),
            ),
          ],
        ),
      ),
    );
  }
}
