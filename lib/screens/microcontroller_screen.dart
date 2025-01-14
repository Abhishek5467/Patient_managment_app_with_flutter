// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// import '../services/microcontroller_service.dart';
import 'dart:async'; // Custom service for microcontroller communication
// import 'bluetooth_screen.dart'; // Screen for Bluetooth scanning and device selection
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MicrocontrollerScreen extends StatefulWidget {
  const MicrocontrollerScreen({super.key});
  @override
  MicrocontrollerScreenState createState() => MicrocontrollerScreenState();
}

class MicrocontrollerScreenState extends State<MicrocontrollerScreen> {
  StreamSubscription<List<ScanResult>>? scanSubscription;
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? controlCharacteristic;

  @override
  void initState() {
    super.initState();
  }

  void connectToMicrocontroller() async {
    try {
      // Start scanning for devices
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
      scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
        for (ScanResult scanResult in results) {
        if (scanResult.device.platformName == 'YourDeviceName') { // Replace with your microcontroller's name
          // Stop scanning
          FlutterBluePlus.stopScan();
          scanSubscription!.cancel();

          // Connect to the device
          await scanResult.device.connect();
          setState(() {
            connectedDevice = scanResult.device;
          });

          // Discover services and characteristics
          List<BluetoothService> services =
              await connectedDevice!.discoverServices();
          for (var service in services) {
            for (var characteristic in service.characteristics) {
              if (characteristic.properties.write) {
                setState(() {
                  controlCharacteristic = characteristic;
                });
              }
            }
          }

          if (controlCharacteristic != null && context.mounted) {

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Connected to Microcontroller!')),
            );
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Control characteristic not found!')),
            );
          }
        }
      }});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error connecting to device: $e')),
      );
    }
  }

  void sendCommand(String command) async {
    if (connectedDevice == null || controlCharacteristic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not connected to any device!')),
      );
      return;
    }

    try {
      // Convert command to bytes and send it
      await controlCharacteristic!.write(command.codeUnits);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Command sent: $command')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send command: $e')),
      );
    }
  }

  @override
  void dispose() {
    // Disconnect from the device when leaving the screen
    connectedDevice?.disconnect();
    super.dispose();
  }

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
