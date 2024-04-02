import 'dart:async';
import 'dart:convert';
import 'package:anti_moustique/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';
import 'package:anti_moustique/backend/schema/structs/functioning_schedule_struct.dart';


typedef jsonObject = Map<String, dynamic>;

enum CommandEnum{
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

Future<bool> sendCommandToDevice(BuildContext context, AntimoustiqueStruct antimoustique, CommandEnum command) async{
    try {
      if (antimoustique.device.isDisconnected || antimoustique.device.remoteId == null) {
        await restoreDeviceConnection(antimoustique);
      }

      var commandService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == '1900');

      await BluetoothActions.discoverCharacteristics(
          antimoustique, commandService);

      var activateCommandCharacteristic = await commandService.characteristics
          .firstWhere((characteristic) =>
              characteristic.uuid.toString() ==
              'fa45d9c7-4068-453d-a18c-e255e2e037bd');

      try{
        await BluetoothActions.writeToCharacteristic(antimoustique: antimoustique, characteristic:  activateCommandCharacteristic, value: [command == CommandEnum.activate ? 1 : 0]);
        return true;
      }
      catch(e){
        print('Error writing to characteristic: $e');
        return false;
      }
      
    } on FlutterBluePlusException catch (e) {
      if (context.mounted) {
        // Add a snackbar to show the error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Erreur dans la communication avec l\'appareil. Assurez vous que l\'appareil est allumé et à proximité.'),
          ),
        );
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
}

Future<bool> addFunctionSchedule(BuildContext context, AntimoustiqueStruct antimoustique, FunctioningScheduleStruct schedule) async{
  int writeCharacteristicIndex = antimoustique.functioningScheduleList.length;

  if(writeCharacteristicIndex >= 3){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Vous avez atteint le nombre maximum de plages horaires'),
      ),
    );
    return false;
  }

  try {
    if (antimoustique.device.isDisconnected || antimoustique.device.remoteId == null) {
      await restoreDeviceConnection(antimoustique);
    }

    var scheduleService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == '6900');

    var fsCharacteristics = await BluetoothActions.discoverCharacteristics(antimoustique, scheduleService);

    var writeCharacteristic = fsCharacteristics[writeCharacteristicIndex];

    String scheduleString = jsonEncode(schedule.toSerializableMap());

    List<int> scheduleBytes = utf8.encode(scheduleString);

    await BluetoothActions.writeToCharacteristic(antimoustique: antimoustique, characteristic:  writeCharacteristic, value: scheduleBytes, allowLongWrite: true);

    return true;
  }
  catch(e){
    print('Error writing to characteristic: $e');
    return false;
  }
}

Future<void> restoreDeviceConnection(AntimoustiqueStruct antimoustique) async{
  await BluetoothActions.scanForDevice(manufactureID: antimoustique.manufactureID);
  BluetoothDevice currentDeviceBtDevice = FlutterBluePlus.lastScanResults.firstWhere((scanResult) => scanResult.device.advName.toString() == antimoustique.manufactureID).device;
  antimoustique.device = currentDeviceBtDevice;
  antimoustique.updateDeviceInfo();
  await BluetoothActions.connectToDevice(antimoustique);
  await BluetoothActions.discoverServices(antimoustique);
}

