import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<BluetoothDevice> devicesList = [];
  late StreamSubscription<List<ScanResult>> scanSubscription;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  void dispose() {
    stopScan();
    super.dispose();
  }

  void startScan() {
    // Start scanning
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4)); 
    
    scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.contains(result.device)) {
          setState(() {
            devicesList.add(result.device);
          });
        }
      }
    }, onDone: stopScan);
  }

  void stopScan() {
    // Stop scanning
    FlutterBluePlus.stopScan();
    scanSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = devicesList[index];
          return ListTile(
            title: Text(device.advName.isNotEmpty ? device.advName : 'Unknown Device'),
            subtitle: Text(device.remoteId.toString()),
            onTap: () async {
              // Connect to the device
              await device.connect();
              // Navigate to a new screen to show device details or perform operations
              if (context.mounted){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetailsScreen(device: device),
                ),
              );
              }
            },
          );
        },
      ),
    );
  }
}

class DeviceDetailsScreen extends StatelessWidget {
  final BluetoothDevice device;

  const DeviceDetailsScreen({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.platformName.isNotEmpty ? device.platformName : 'Device Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Device ID: ${device.remoteId}'),
            Text('Device Name: ${device.platformName.isNotEmpty ? device.platformName : 'Unknown'}'),
            ElevatedButton(
              onPressed: () async {
                // Disconnect from the device
                await device.disconnect();
                if (context.mounted){
                  Navigator.pop(context);
                }
              },
              child: Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}
