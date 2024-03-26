import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';

class BluetoothActions {


    // write a constructor

    static StreamSubscription<List<ScanResult>>? _scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
            if (results.isNotEmpty) {
                ScanResult r = results.last;
                print('Device id : ${r.device.remoteId}, Name : ${r.advertisementData.advName}');
            }
        }, onError: (e) => print('Error: $e'));

    StreamSubscription<List<ScanResult>>? get scanSubscription => _scanSubscription;
    set scanSubscription(StreamSubscription<List<ScanResult>>? val) => _scanSubscription = val;
    bool hasScanSubscription() => _scanSubscription != null;

    static Future<void> scanForDevice({String name = ''}) async{

        FlutterBluePlus.cancelWhenScanComplete(_scanSubscription!);

        await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;

        await FlutterBluePlus.startScan(timeout: Duration(seconds: 4), withNames: name.isNotEmpty ? [name] : const []);

        await FlutterBluePlus.isScanning.where((val) => val == false).first;

    }

    static Future<void> connectToDevice(AntimoustiqueStruct antimoustique) async {

        antimoustique.device.cancelWhenDisconnected(antimoustique.connectionSubscription!, delayed: true, next: true);

        await antimoustique.device.connect(autoConnect: true, mtu: null);

        print('Connected to device ${antimoustique.device.remoteId}');

        await antimoustique.device.connectionState.where((val) => val == BluetoothConnectionState.connected).first;
    }

    static Future<void> disconnectFromDevice(AntimoustiqueStruct antimoustique) async {

        await antimoustique.device.disconnect();

        print('Disconnected from device ${antimoustique.device.remoteId}');

        antimoustique.connectionSubscription!.cancel();
    }


}
