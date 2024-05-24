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
import 'constants.dart';

// Restaure la connexion avec l'appareil si nécessaire.
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

// Met à jour les informations de l'appareil, comme le niveau de CO2 et d'attractif.
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
    var activateCommandCharacteristic =
        deviceCommandCharacteristicList.firstWhere((characteristic) => characteristic.uuid.toString() == activateCommandCharacteristicUUID);

    var functioningScheduleService =
        await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == functioningScheduleServiceUUID);
    var functioningScheduleCharacteristics = await BluetoothActions.discoverCharacteristics(antimoustique, functioningScheduleService);

    List<FunctioningScheduleStruct> schedules = [];

    for (var characteristic in functioningScheduleCharacteristics) {
      var scheduleBytes = await BluetoothActions.readFromCharacteristic(antimoustique, characteristic);
      if (scheduleBytes.isNotEmpty) {
        var scheduleString = utf8.decode(scheduleBytes);
        var scheduleMap = jsonDecode(scheduleString);
        schedules.add(FunctioningScheduleStruct.fromSerializableMap(scheduleMap));
      }
    }

    antimoustique.functioningScheduleList = schedules;

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

Future<void> refreshAllDevices(List<AntimoustiqueStruct> devices) async {
  if (devices.isEmpty) {
    print('No devices to refresh.');
    return;
  }
  for (var device in devices) {
    try {
      refreshDeviceInformation(device);
    } catch (e) {
      print('Error refreshing device information: $e');
    }
  }
}