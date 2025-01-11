import 'package:flutter/material.dart';
import '../services/microcontroller_service.dart';

class MicrocontrollerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Microcontroller Connectivity')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: connectToMicrocontroller,
              child: Text('Connect via Bluetooth'),
            ),
            ElevatedButton(
              onPressed: () => sendCommand('START'),
              child: Text('Send Command'),
            ),
          ],
        ),
      ),
    );
  }
}
