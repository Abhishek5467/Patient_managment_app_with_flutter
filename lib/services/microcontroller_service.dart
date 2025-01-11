import 'package:flutter_blue/flutter_blue.dart';
import 'package:http/http.dart' as http;

// Connect to Microcontroller via Bluetooth
Future<void> connectToMicrocontroller() async {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  // Start scanning for devices
  flutterBlue.startScan(timeout: Duration(seconds: 4));

  // Listen to scan results
  flutterBlue.scanResults.listen((results) {
    for (ScanResult result in results) {
      if (result.device.name == 'ESP32') {
        // Connect to the device
        result.device.connect();
        print('Connected to ESP32');
      }
    }
  });

  // Stop scanning after 4 seconds
  flutterBlue.stopScan();
}

// Send Command to Microcontroller via Wi-Fi
Future<void> sendCommand(String command) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.1/command'),
      body: {'command': command},
    );

    if (response.statusCode == 200) {
      print('Command sent successfully');
    } else {
      print('Failed to send command');
    }
  } catch (e) {
    print('Error sending command: $e');
  }
}
