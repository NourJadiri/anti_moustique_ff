import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';
import 'package:anti_moustique/app_state.dart';

class BluetoothActions {
  static StreamSubscription<List<ScanResult>>? _scanSubscription =
      FlutterBluePlus.onScanResults.listen((results) {
    if (results.isNotEmpty) {
      ScanResult r = results.last;
      print(
          'Device id : ${r.device.remoteId}, Name : ${r.advertisementData.advName}');
    }
  }, onError: (e) => print('Error: $e'));

  StreamSubscription<List<ScanResult>>? get scanSubscription =>
      _scanSubscription;
  set scanSubscription(StreamSubscription<List<ScanResult>>? val) =>
      _scanSubscription = val;
  bool hasScanSubscription() => _scanSubscription != null;

  static Future<void> scanForDevice(
      {String manufactureID = '',
      String remoteID = '',
      Duration timeout = const Duration(seconds: 1)}) async {
    FlutterBluePlus.cancelWhenScanComplete(_scanSubscription!);

    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan(
        timeout: timeout,
        withNames: manufactureID.isNotEmpty ? [manufactureID] : const [],
        withRemoteIds: remoteID.isNotEmpty ? [remoteID] : const []);

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }

  static Future<void> connectToDevice(AntimoustiqueStruct antimoustique) async {
    await antimoustique.device.connect(mtu: null);

    print('Connected to device ${antimoustique.device.remoteId}');
  }

  static Future<List<BluetoothService>> discoverServices(
      AntimoustiqueStruct antimoustique) async {
    var services = await antimoustique.device.discoverServices();

    services.forEach((service) {
      print(
          'Discovered service ${service.uuid} on device ${antimoustique.device.remoteId}');
    });

    return services;
  }

  static Future<List<BluetoothCharacteristic>> discoverCharacteristics(
      AntimoustiqueStruct antimoustique, BluetoothService service) async {
    var characteristics = service.characteristics;

    return characteristics;
  }

  // Example of a refactored helper method
  static Future<List<BluetoothCharacteristic>> discoverCharacteristicsForServiceUUID(
      AntimoustiqueStruct antimoustique, String serviceUUID) async {
    try {
      return await BluetoothActions.discoverCharacteristics(
          antimoustique,
          antimoustique.device.servicesList
              .firstWhere((service) => service.uuid.toString() == serviceUUID));
    } catch (e) {
      print(
          'Error discovering characteristics for service UUID $serviceUUID: $e');
      rethrow; // This allows the calling method to handle the exception
    }
  }

  static Future<void> writeToCharacteristic(
      {required AntimoustiqueStruct antimoustique,
      required BluetoothCharacteristic characteristic,
      required List<int> value,
      bool allowLongWrite = false}) async {
    try {
      // if the device is disconnected, we need to reconnect
      if (antimoustique.device.state != BluetoothDeviceState.connected) {
        await antimoustique.device.connect(mtu: null);
      }
      await characteristic.write(value, allowLongWrite: allowLongWrite);
      print(
          'Wrote to characteristic ${characteristic.uuid} on device ${antimoustique.device.remoteId}');
    } catch (e) {
      throw Exception(
          'Error writing to characteristic ${characteristic.uuid} on device ${antimoustique.device.remoteId}');
    }
  }

  static Future<List<int>> readFromCharacteristic(
      AntimoustiqueStruct antimoustique,
      BluetoothCharacteristic characteristic) async {
    try {
      var value = await characteristic.read();
      print(
          'Read from characteristic ${characteristic.uuid}, value : ${value}');
      return value;
    } catch (e) {
      print(
          'Error reading from characteristic ${characteristic.uuid} on device ${antimoustique.device.remoteId}');
      return [];
    }
  }

  static Future<void> disconnectFromDevice(
      AntimoustiqueStruct antimoustique) async {
    await antimoustique.device.disconnect();

    print('Disconnected from device ${antimoustique.device.remoteId}');

    antimoustique.connectionSubscription!.cancel();
  }
}
