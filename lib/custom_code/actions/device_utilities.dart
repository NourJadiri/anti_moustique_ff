import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:anti_moustique/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';
import 'package:anti_moustique/backend/schema/structs/functioning_schedule_struct.dart';
import 'package:anti_moustique/backend/schema/structs/notification_struct.dart';
import 'device_connection.dart';
import 'constants.dart';

// UUIDs pour différents services et caractéristiques BLE utilisés par l'appareil.


typedef jsonObject = Map<String, dynamic>;

// Enumération pour les commandes pouvant être envoyées à l'appareil.
enum CommandEnum {
  deactivate,
  activate,
}

// Scanne un QR code et retourne les données décodées si elles contiennent les champs requis.
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
    if (qrData.containsKey('manufactureID') && qrData.containsKey('remoteID') && qrData.containsKey('vendor')) {
      // Extract manufactureID, remoteID, and vendor from the decoded JSON
      String manufactureID = qrData['manufactureID'];
      String remoteID = qrData['remoteID'];
      String vendor = qrData['vendor'];
      Map<String,dynamic> services = qrData['services'];

      return {
        'manufactureID': manufactureID,
        'remoteID': remoteID,
        'vendor': vendor,
        'services': services,
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

// Utilise les données d'un QR code pour obtenir un objet AntimoustiqueStruct représentant l'appareil.
Future<AntimoustiqueStruct> getDeviceFromQR(BuildContext context, Map<String, dynamic> qrData) async {
  try {
    await BluetoothActions.scanForDevice(manufactureID: qrData['manufactureID'], timeout: const Duration(seconds: 2));

    if (FlutterBluePlus.lastScanResults.isEmpty) {
      throw Exception('Aucun appareil trouvé, assurez-vous que l\'appareil est activé et qu\'il est à proximité.');
    }

    BluetoothDevice device = FlutterBluePlus.lastScanResults.firstWhere(
      (scanResult) => scanResult.device.advName.toString() == qrData['manufactureID'],
      orElse: () {
        throw Exception('Aucun appareil correspondant au ID de fabrication trouvé.');
      },
    ).device;

    return AntimoustiqueStruct(
      manufactureID: qrData['manufactureID'],
      remoteID: device.remoteId.toString(),
      vendor: qrData['vendor'],
      device: device,
      isOn: false,
      serviceMap: qrData['services'],
    );
  } catch (e) {
    // Vous pouvez gérer ou relancer l'exception selon votre cas d'utilisation.
    // Par exemple, afficher une SnackBar avec l'erreur:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
    // Relancer l'exception si nécessaire
    throw e;
  }
}

// Envoie une commande à l'appareil et retourne le succès de l'opération.
Future<bool> sendCommandToDevice(BuildContext context, AntimoustiqueStruct antimoustique, CommandEnum command) async {
  try {
    if (antimoustique.device.isDisconnected || antimoustique.device.remoteId == null) {
      await restoreDeviceConnection(antimoustique);
    }

    var commandService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == '1900');

    await BluetoothActions.discoverCharacteristics(antimoustique, commandService);

    var activateCommandCharacteristic =
        await commandService.characteristics.firstWhere((characteristic) => characteristic.uuid.toString() == activateCommandCharacteristicUUID);

    try {
      await BluetoothActions.writeToCharacteristic(
          antimoustique: antimoustique, characteristic: activateCommandCharacteristic, value: [command == CommandEnum.activate ? 1 : 0]);
      return true;
    } catch (e) {
      print('Error writing to characteristic: $e');
      return false;
    }
  } on FlutterBluePlusException catch (e) {
    if (context.mounted) {
      // Add a snackbar to show the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur dans la communication avec l\'appareil. Assurez vous que l\'appareil est allumé et à proximité.'),
        ),
      );
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}


