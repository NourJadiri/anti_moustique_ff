import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';


typedef jsonObject = Map<String, dynamic>;

Future<jsonObject> scanQR(BuildContext context) async {
  try {
    String qrResult = await FlutterBarcodeScanner.scanBarcode(
      '#C62828', // scanning line color
      'Cancel', // cancel button text
      true, // whether to show the flash icon
      ScanMode.QR,
    );

    // Decode the scanned JSON data
    Map<String, dynamic> qrData = jsonDecode(qrResult);

    // Check if all required fields (manufactureID, remoteID, vendor) are present
    if (qrData.containsKey('manufactureID') &&
        qrData.containsKey('remoteID') &&
        qrData.containsKey('vendor')) {
      // Extract manufactureID, remoteID, and vendor from the decoded JSON
      String manufactureID = qrData['manufactureID'];
      String remoteID = qrData['remoteID'];
      String vendor = qrData['vendor'];

      return {
        'manufactureID': manufactureID,
        'remoteID': remoteID,
        'vendor': vendor,
      };

    } else {
      // Show error message if any of the required fields are missing
      print('Error: Missing required fields in QR code data');
      return {};
    }
  } catch (e) {
    print("Error scanning QR code: $e");
    // Show an error message to the user
    return {};
  }
}

Future<AntimoustiqueStruct> getDeviceFromQR(BuildContext context, jsonObject qrData) async {

  
  await BluetoothActions.scanForDevice(manufactureID: qrData['manufactureID']);

  if(FlutterBluePlus.lastScanResults.isEmpty){
    print('No devices found');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Aucun appareil trouvé, assurez-vous que l\'appareil est activé et qu\'il est à proximité'),
        ),
      );
      return AntimoustiqueStruct();
  }

  BluetoothDevice device = FlutterBluePlus.lastScanResults.firstWhere((scanResult) => scanResult.device.advName.toString() == qrData['manufactureID']).device;

  return AntimoustiqueStruct(
    manufactureID: qrData['manufactureID'],
    remoteID: device.remoteId.toString(),
    vendor: qrData['vendor'],
    device: device,
    isOn: true,
  );
}
