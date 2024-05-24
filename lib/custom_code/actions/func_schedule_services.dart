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
import 'device_connection.dart';

// Ajoute un horaire de fonctionnement à l'appareil.
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

Future<void> deleteFunctioningSchedule(AntimoustiqueStruct antimoustique, int index) async {
  try {
    var scheduleService = await antimoustique.device.servicesList.firstWhere((service) => service.uuid.toString() == functioningScheduleServiceUUID);

    var fsCharacteristics = await BluetoothActions.discoverCharacteristics(antimoustique, scheduleService);

    var deleteCharacteristic = fsCharacteristics[index];

    List<int> emptyBytes = [];

    try {
      await BluetoothActions.writeToCharacteristic(antimoustique: antimoustique, characteristic: deleteCharacteristic, value: emptyBytes);
    } catch (e) {
      print('Error writing to characteristic: $e');
    }
  } catch (e) {
    print('Error discovering services and characteristics: $e');
  }
}

// Trouve un indice de caractéristique vide pour ajouter un nouvel horaire.
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