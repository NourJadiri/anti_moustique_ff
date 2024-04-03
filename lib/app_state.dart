import 'package:anti_moustique/services/notification_service.dart';
import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _deviceList = prefs
              .getStringList('ff_deviceList')
              ?.map((x) {
                try {
                  return AntimoustiqueStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _deviceList;
    });
    _safeInit(() {
      _googleMapData = prefs
              .getStringList('ff_googleMapData')
              ?.map((x) {
                try {
                  return GoogleMapDataStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _googleMapData;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_currentDevice')) {
        try {
          final serializedData = prefs.getString('ff_currentDevice') ?? '{}';
          _currentDevice = AntimoustiqueStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _notificationList = prefs
              .getStringList('ff_notificationList')
              ?.map((x) {
                try {
                  return NotificationStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _notificationList;
    });
    _safeInit(() {
      _functioningScheduleList = prefs
              .getStringList('ff_functioningScheduleList')
              ?.map((x) {
                try {
                  return FunctioningScheduleStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _functioningScheduleList;
    });
  }


  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<AntimoustiqueStruct> _deviceList = [];

  List<AntimoustiqueStruct> get deviceList => _deviceList;
  set deviceList(List<AntimoustiqueStruct> value) {
    _deviceList = value;
    prefs.setStringList(
        'ff_deviceList', value.map((x) => x.serialize()).toList());
  }

  void addToDeviceList(AntimoustiqueStruct value) {
    _deviceList.add(value);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());

  }

  void removeFromDeviceList(AntimoustiqueStruct value) {
    _deviceList.remove(value);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDeviceList(int index) {
    _deviceList.removeAt(index);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());
  }

  void updateDeviceListAtIndex(
    int index,
    AntimoustiqueStruct Function(AntimoustiqueStruct) updateFn,
  ) {
    _deviceList[index] = updateFn(_deviceList[index]);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDeviceList(int index, AntimoustiqueStruct value) {
    _deviceList.insert(index, value);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());
  }

  List<GoogleMapDataStruct> _googleMapData = [];
  List<GoogleMapDataStruct> get googleMapData => _googleMapData;
  set googleMapData(List<GoogleMapDataStruct> value) {
    _googleMapData = value;
    prefs.setStringList(
        'ff_googleMapData', value.map((x) => x.serialize()).toList());
  }

  void addToGoogleMapData(GoogleMapDataStruct value) {
    _googleMapData.add(value);
    prefs.setStringList(
        'ff_googleMapData', _googleMapData.map((x) => x.serialize()).toList());
  }

  void removeFromGoogleMapData(GoogleMapDataStruct value) {
    _googleMapData.remove(value);
    prefs.setStringList(
        'ff_googleMapData', _googleMapData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromGoogleMapData(int index) {
    _googleMapData.removeAt(index);
    prefs.setStringList(
        'ff_googleMapData', _googleMapData.map((x) => x.serialize()).toList());
  }

  void updateGoogleMapDataAtIndex(
    int index,
    GoogleMapDataStruct Function(GoogleMapDataStruct) updateFn,
  ) {
    _googleMapData[index] = updateFn(_googleMapData[index]);
    prefs.setStringList(
        'ff_googleMapData', _googleMapData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInGoogleMapData(int index, GoogleMapDataStruct value) {
    _googleMapData.insert(index, value);
    prefs.setStringList(
        'ff_googleMapData', _googleMapData.map((x) => x.serialize()).toList());
  }

  AntimoustiqueStruct _currentDevice = AntimoustiqueStruct();
  AntimoustiqueStruct get currentDevice => _currentDevice;
  set currentDevice(AntimoustiqueStruct value) {
    _currentDevice = value;
    prefs.setString('ff_currentDevice', value.serialize());
  }

  void updateCurrentDeviceStruct(Function(AntimoustiqueStruct) updateFn) {
    updateFn(_currentDevice);
    prefs.setString('ff_currentDevice', _currentDevice.serialize());
  }

  List<NotificationStruct> _notificationList = [];
  List<NotificationStruct> get notificationList => _notificationList;
  set notificationList(List<NotificationStruct> value) {
    _notificationList = value;
    prefs.setStringList(
        'ff_notificationList', value.map((x) => x.serialize()).toList());
  }

  void addToNotificationList(NotificationStruct value) {
    _notificationList.add(value);
    prefs.setStringList('ff_notificationList',
        _notificationList.map((x) => x.serialize()).toList());
    // Envoyer une notification
    NotificationService().sendLocalNotification(value);
  }

  void removeFromNotificationList(NotificationStruct value) {
    _notificationList.remove(value);
    prefs.setStringList('ff_notificationList',
        _notificationList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromNotificationList(int index) {
    _notificationList.removeAt(index);
    prefs.setStringList('ff_notificationList',
        _notificationList.map((x) => x.serialize()).toList());
  }

  void updateNotificationListAtIndex(
    int index,
    NotificationStruct Function(NotificationStruct) updateFn,
  ) {
    _notificationList[index] = updateFn(_notificationList[index]);
    prefs.setStringList('ff_notificationList',
        _notificationList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInNotificationList(int index, NotificationStruct value) {
    _notificationList.insert(index, value);
    prefs.setStringList('ff_notificationList',
        _notificationList.map((x) => x.serialize()).toList());
  }

  List<FunctioningScheduleStruct> _functioningScheduleList = [];
  List<FunctioningScheduleStruct> get functioningScheduleList =>
      _functioningScheduleList;
  set functioningScheduleList(List<FunctioningScheduleStruct> value) {
    _functioningScheduleList = value;
    prefs.setStringList('ff_functioningScheduleList',
        value.map((x) => x.serialize()).toList());
  }

  void addToFunctioningScheduleList(FunctioningScheduleStruct value) {
    _functioningScheduleList.add(value);
    prefs.setStringList('ff_functioningScheduleList',
        _functioningScheduleList.map((x) => x.serialize()).toList());
  }


  void removeFromFunctioningScheduleList(FunctioningScheduleStruct value) {
    _functioningScheduleList.remove(value);
    prefs.setStringList('ff_functioningScheduleList',
        _functioningScheduleList.map((x) => x.serialize()).toList());
  }


  void updateFunctioningScheduleListAtIndex(
    int index,
    FunctioningScheduleStruct Function(FunctioningScheduleStruct) updateFn,
  ) {
    _functioningScheduleList[index] =
        updateFn(_functioningScheduleList[index]);
    prefs.setStringList('ff_functioningScheduleList',
        _functioningScheduleList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInFunctioningScheduleList(
      int index, FunctioningScheduleStruct value) {
    _functioningScheduleList.insert(index, value);
    prefs.setStringList('ff_functioningScheduleList',
        _functioningScheduleList.map((x) => x.serialize()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
