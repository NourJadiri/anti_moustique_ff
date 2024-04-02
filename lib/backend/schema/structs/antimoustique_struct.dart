// ignore_for_file: unnecessary_getters_setters

import 'dart:async';
import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AntimoustiqueStruct extends BaseStruct {
  AntimoustiqueStruct({
    String? manufactureID,
    String? vendor = 'unknown',
    String? name,
    String? remoteID,
    double? attractif = 0,
    double? co2 = 0,
    bool? isOn = false,
    BluetoothDevice? device,
    List<FunctioningScheduleStruct>? functioningScheduleList, // Ajout du paramètre
  }) {
    _manufactureID = manufactureID;
    _vendor = vendor;
    _name = name;
    _remoteID = remoteID;
    _attractif = attractif;
    _co2 = co2;
    _isOn = isOn;
    _device = device;
    device = device;
    _functioningScheduleList = functioningScheduleList ?? []; // Initialisation avec une liste vide par défaut
    _connectionSubscription = _device?.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        print('Disconnected from device ${device!.advName}');
      }
    });

     _onServiceResetSubscription = _device?.onServicesReset.listen((_) async{
        print('Services reset');
        await _device?.discoverServices();
     });

     _device?.cancelWhenDisconnected(_connectionSubscription!, delayed: true, next: true);
  }

  StreamSubscription<void>? _onServiceResetSubscription;
  get onServiceResetSubscription => _onServiceResetSubscription;
  set onServiceResetSubscription(val) => _onServiceResetSubscription = val;

  // Stream subscription for connection state.
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<BluetoothConnectionState>? get connectionSubscription => _connectionSubscription;
  set connectionSubscription(StreamSubscription<BluetoothConnectionState>? val) => _connectionSubscription = val;
  bool hasConnectionSubscription() => _connectionSubscription != null;

  // "manufactureID" field.
  String? _manufactureID;
  String get manufactureID => _manufactureID ?? '';
  set manufactureID(String? val) => _manufactureID = val;
  bool hasManufactureID() => _manufactureID != null;

  // "vendor" field.
  String? _vendor;
  String get vendor => _vendor ?? '';
  set vendor(String? val) => _vendor = val;
  bool hasVendor() => _vendor != null;

  // "name" field.
  String? _name;
  String get name => _name ?? 'maxSize(15)';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "remoteID" field.
  String? _remoteID;
  String get remoteID => _remoteID ?? '';
  set remoteID(String? val) => _remoteID = val;
  bool hasRemoteID() => _remoteID != null;

  // "attractif" field.
  double? _attractif;
  double get attractif => _attractif ?? 0.0;
  set attractif(double? val) => _attractif = val;
  void incrementAttractif(double amount) => _attractif = attractif + amount;
  bool hasAttractif() => _attractif != null;

  // "co2" field.
  double? _co2;
  double get co2 => _co2 ?? 0.0;
  set co2(double? val) => _co2 = val;
  void incrementCo2(double amount) => _co2 = co2 + amount;
  bool hasCo2() => _co2 != null;

  // "isOn" field.
  bool? _isOn;
  bool get isOn => _isOn ?? false;
  set isOn(bool? val) => _isOn = val;
  bool hasIsOn() => _isOn != null;

  // "functioning schedule list" field.
  List<FunctioningScheduleStruct>? _functioningScheduleList;

  List<FunctioningScheduleStruct> get functioningScheduleList =>
      _functioningScheduleList ?? [];
  set functioningScheduleList(List<FunctioningScheduleStruct>? value) {
    _functioningScheduleList = value;
  }
  bool? hasFunctioningScheduleList() => _functioningScheduleList != null;

  // Méthode pour ajouter une plage horaire
  void addFunctioningSchedule(FunctioningScheduleStruct schedule) {
    _functioningScheduleList ??= [];
    _functioningScheduleList!.add(schedule);
  }

  // Méthode pour supprimer une plage horaire
  void removeFunctioningSchedule(FunctioningScheduleStruct schedule) {
    _functioningScheduleList?.remove(schedule);
  }
  void removeAtIndexFromFunctioningScheduleList(int index) {
    _functioningScheduleList?.removeAt(index);
  }

  // Méthode pour mettre à jour une plage horaire
  void updateFunctioningSchedule(int index, FunctioningScheduleStruct updatedSchedule) {
    if (_functioningScheduleList != null && index >= 0 && index < _functioningScheduleList!.length) {
      _functioningScheduleList![index] = updatedSchedule;
    }
  }

  // "device" field.
  BluetoothDevice? _device;
  BluetoothDevice get device =>
      _device ?? BluetoothDevice(remoteId: const DeviceIdentifier(''));
  set device(BluetoothDevice val) => _device = val;
  bool hasDevice() => _device != null;



  static AntimoustiqueStruct fromMap(Map<String, dynamic> data) =>
      AntimoustiqueStruct(
        manufactureID: data['manufactureID'] as String?,
        vendor: data['vendor'] as String?,
        name: data['name'] as String?,
        remoteID: data['remoteID'] as String?,
        attractif: castToType<double>(data['attractif']),
        co2: castToType<double>(data['co2']),
        isOn: data['isOn'] as bool?,
        functioningScheduleList: (data['functioningScheduleList'] as List<dynamic>?)
            ?.map((scheduleData)
        => FunctioningScheduleStruct.fromMap(scheduleData.cast<String, dynamic>()))
            .toList(),
      );

  static AntimoustiqueStruct? maybeFromMap(dynamic data) => data is Map
      ? AntimoustiqueStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
    'manufactureID': _manufactureID,
    'vendor': _vendor,
    'name': _name,
    'remoteID': _remoteID,
    'attractif': _attractif,
    'co2': _co2,
    'isOn': _isOn,
    'device': {
      'remoteId': _device?.remoteId.toString(),
      'name': _device?.advName,
    },
    'functioningScheduleList' : _functioningScheduleList,
  }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
    'manufactureID': serializeParam(
      _manufactureID,
      ParamType.String,
    ),
    'vendor': serializeParam(
      _vendor,
      ParamType.String,
    ),
    'name': serializeParam(
      _name,
      ParamType.String,
    ),
    'remoteID': serializeParam(
      _remoteID,
      ParamType.String,
    ),
    'attractif': serializeParam(
      _attractif,
      ParamType.double,
    ),
    'co2': serializeParam(
      _co2,
      ParamType.double,
    ),
    'isOn': serializeParam(
      _isOn,
      ParamType.bool,
    ),
    'device': {
      'remoteId': serializeParam(
        _device?.remoteId.toString(),
        ParamType.String,
      ),
      'name': serializeParam(
        _device?.advName,
        ParamType.String,
      ),
    },
  }.withoutNulls;

  static AntimoustiqueStruct fromSerializableMap(Map<String, dynamic> data) =>
      AntimoustiqueStruct(
        manufactureID: deserializeParam(
          data['manufactureID'],
          ParamType.String,
          false,
        ),
        vendor: deserializeParam(
          data['vendor'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        remoteID: deserializeParam(
          data['remoteID'],
          ParamType.String,
          false,
        ),
        attractif: deserializeParam(
          data['attractif'],
          ParamType.double,
          false,
        ),
        co2: deserializeParam(
          data['co2'],
          ParamType.double,
          false,
        ),
        isOn: deserializeParam(
          data['isOn'],
          ParamType.bool,
          false,
        ),
        functioningScheduleList: (data['functioningScheduleList'] as List<dynamic>?)
            ?.map((scheduleData) => FunctioningScheduleStruct.fromMap(scheduleData.cast<String, dynamic>()))
            .toList(),
      );

  @override
  String toString() => 'AntimoustiqueStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AntimoustiqueStruct &&
        manufactureID == other.manufactureID &&
        vendor == other.vendor &&
        name == other.name &&
        remoteID == other.remoteID &&
        attractif == other.attractif &&
        co2 == other.co2 &&
        isOn == other.isOn;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([manufactureID, vendor, name, remoteID, attractif, co2, isOn]);
}

AntimoustiqueStruct createAntimoustiqueStruct({
  String? manufactureID,
  String? vendor,
  String? name,
  String? remoteID,
  double? attractif,
  double? co2,
  bool? isOn,
  BluetoothDevice? device,
}) =>
    AntimoustiqueStruct(
      manufactureID: manufactureID,
      vendor: vendor,
      name: name,
      remoteID: remoteID,
      attractif: attractif,
      co2: co2,
      isOn: isOn,
    );
