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

final String deviceInfoServiceUUID = '180d';
final String deviceCommandServiceUUID = '1900';
final String functioningScheduleServiceUUID = '6900';
final String co2LevelCharacteristicUUID = '289f1cd7-546b-4c3d-b760-a353592e196c';
final String attractifLevelCharacteristicUUID = 'cf862a6b-8f91-4d53-a396-70d91a25ce9b';

typedef jsonObject = Map<String, dynamic>;

enum CommandEnum {
  deactivate,
  activate,
}

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

Future<AntimoustiqueStruct> getDeviceFromQR(BuildContext context, Map<String, dynamic> qrData) async {
  try {
    await BluetoothActions.scanForDevice(manufactureID: qrData['manufactureID']);

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

Future<bool> sendCommandToDevice(BuildContext context, AntimoustiqueStruct antimoustique, CommandEnum command) async {
  try {
    if (antimoustique.device.isDisconnected || antimoustique.device.remoteId == null) {
      await restoreDeviceConnection(antimoustique);
    }

    var commandService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == '1900');

    await BluetoothActions.discoverCharacteristics(antimoustique, commandService);

    var activateCommandCharacteristic =
        await commandService.characteristics.firstWhere((characteristic) => characteristic.uuid.toString() == 'fa45d9c7-4068-453d-a18c-e255e2e037bd');

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

Future<bool> addFunctionSchedule(BuildContext context, AntimoustiqueStruct antimoustique, FunctioningScheduleStruct schedule) async {
  var writeCharacteristicIndex = -1;

  try {
    if (antimoustique.device.isDisconnected || antimoustique.device.remoteId == null) {
      await restoreDeviceConnection(antimoustique);
    }

    var scheduleService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == functioningScheduleServiceUUID);

    var fsCharacteristics = await BluetoothActions.discoverCharacteristics(antimoustique, scheduleService);

    writeCharacteristicIndex = await findEmptyCharacteristicIndex(fsCharacteristics, antimoustique);

    var writeCharacteristic = fsCharacteristics[writeCharacteristicIndex];

    String scheduleString = jsonEncode(schedule.toSerializableMap());

    List<int> scheduleBytes = utf8.encode(scheduleString);

    try {
      await BluetoothActions.writeToCharacteristic(
          antimoustique: antimoustique, characteristic: writeCharacteristic, value: scheduleBytes, allowLongWrite: true);
      return true;
    } catch (e) {
      return false;
    }
  } catch (e) {
    print('Error writing to characteristic: $e');
    return false;
  }
}

Future<void> restoreDeviceConnection(AntimoustiqueStruct antimoustique) async {
  try {
    await BluetoothActions.scanForDevice(manufactureID: antimoustique.manufactureID);
    if (FlutterBluePlus.lastScanResults.isEmpty) {
      throw Exception('Aucun appareil trouvé lors de la numérisation.');
    }
    BluetoothDevice currentDeviceBtDevice;
    try {
      currentDeviceBtDevice = FlutterBluePlus.lastScanResults
          .firstWhere(
            (scanResult) => scanResult.device.advName.toString() == antimoustique.manufactureID,
          )
          .device;
    } catch (e) {
      throw Exception('Appareil avec manufactureID ${antimoustique.manufactureID} non trouvé.');
    }

    antimoustique.device = currentDeviceBtDevice;
    antimoustique.updateDeviceInfo();

    await BluetoothActions.connectToDevice(antimoustique);
    await BluetoothActions.discoverServices(antimoustique);
  } catch (e) {
    throw Exception('La restauration de la connexion a échoué: $e');
  }
}

Future<void> refreshDeviceInformation(AntimoustiqueStruct antimoustique) async {
  if (!antimoustique.device.isConnected) {
    try {
      await restoreDeviceConnection(antimoustique);
    } catch (e) {
      print('Error connecting to device: $e');
      rethrow;
    }
  }

  try {
    var deviceInfoCharacteristicList = await BluetoothActions.discoverCharacteristicsForServiceUUID(antimoustique, deviceInfoServiceUUID);
    var deviceCommandCharacteristicList = await BluetoothActions.discoverCharacteristicsForServiceUUID(antimoustique, deviceCommandServiceUUID);

    var co2Characteristic = deviceInfoCharacteristicList.firstWhere((characteristic) => characteristic.uuid.toString() == co2LevelCharacteristicUUID);
    var attractifCharacteristic =
        deviceInfoCharacteristicList.firstWhere((characteristic) => characteristic.uuid.toString() == attractifLevelCharacteristicUUID);
    var deviceCommandCharacteristic =
        deviceCommandCharacteristicList.firstWhere((characteristic) => characteristic.uuid.toString() == 'fa45d9c7-4068-453d-a18c-e255e2e037bd');

    // Reading characteristics
    var co2Level = await BluetoothActions.readFromCharacteristic(antimoustique, co2Characteristic);
    var attractifLevel = await BluetoothActions.readFromCharacteristic(antimoustique, attractifCharacteristic);

    // Updating antimoustique properties
    antimoustique.co2 = co2Level.first / 100;
    antimoustique.attractif = attractifLevel.first / 100;
  } catch (e) {
    print('Error discovering services and characteristics: $e');

    rethrow; // Rethrows the caught exception
  }
}

Future<int> findEmptyCharacteristicIndex(List<BluetoothCharacteristic> characteristics, AntimoustiqueStruct antimoustique) async {
  int emptyCharacteristicIndex = -1;

  for (var characteristic in characteristics) {
    var value = await BluetoothActions.readFromCharacteristic(antimoustique, characteristic);
    if (value.isEmpty || String.fromCharCodes(value).trim().isEmpty) {
      emptyCharacteristicIndex = characteristics.indexOf(characteristic);
      break;
    }
  }

  return emptyCharacteristicIndex;
}
