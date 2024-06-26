import 'package:anti_moustique/services/notification_service.dart';
import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';


// Classe FFAppState utilisée pour gérer l'état global de l'application. Elle utilise le pattern singleton pour s'assurer qu'une seule instance est créée.

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();   // Instance unique de FFAppState.

  // Factory constructor pour accéder à l'instance singleton.
  factory FFAppState() {
    return _instance;
  }

  // Constructeur privé utilisé pour créer l'instance singleton.
  FFAppState._internal();

  // Réinitialise l'instance à son état initial. Utilisé pour les tests ou la réinitialisation de l'application.
  static void reset() {
    _instance = FFAppState._internal();
  }

  // Initialise l'état persistant de l'application à partir des SharedPreferences.
  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    // Charge la liste des appareils enregistrés.
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
    // Charge les données des cartes Google.
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
    // Charge l'appareil actuellement sélectionné.
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
    // Charge la liste des notifications.
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

  // Met à jour l'état de l'application et notifie les écouteurs de changements.
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  // SharedPreferences utilisées pour la persistance des données.
  late SharedPreferences prefs;

  // Gestion de la liste des appareils (AntimoustiqueStruct).
  List<AntimoustiqueStruct> _deviceList = [];

  List<AntimoustiqueStruct> get deviceList => _deviceList;
  set deviceList(List<AntimoustiqueStruct> value) {
    _deviceList = value;
    prefs.setStringList(
        'ff_deviceList', value.map((x) => x.serialize()).toList());
  }

  // Plusieurs méthodes pour ajouter, retirer ou mettre à jour des appareils dans la liste.
  void addToDeviceList(AntimoustiqueStruct value) {
    _deviceList.add(value);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());

  }

  void removeFromDeviceList(AntimoustiqueStruct value) {
    // Supprimez d'abord les notifications pour l'appareil
    removeNotificationsForDevice(value);

    if (_currentDevice == value) {
      _currentDevice = null;
      // Update your state or UI as necessary to reflect no current device
    }
    _deviceList.remove(value);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());
    notifyListeners();
  }

  void removeAtIndexFromDeviceList(int index) {
    // First, get the device at the given index.
    var deviceToRemove = _deviceList.elementAt(index);
    // Supprimez d'abord les notifications pour l'appareil
    removeNotificationsForDevice(deviceToRemove);
    // Check if the device to remove is the current device.
    if (_currentDevice != null && _currentDevice == deviceToRemove) {
      // If it is the current device, set the current device to null.
      currentDevice = null; // This will also update SharedPreferences accordingly.
    }

    // Now it is safe to remove the device from the device list.
    _deviceList.removeAt(index);
    prefs.setStringList(
        'ff_deviceList', _deviceList.map((x) => x.serialize()).toList());

    // Notify all listeners of the change.
    notifyListeners();
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

  // Gestion de la liste des données de carte Google.

  List<GoogleMapDataStruct> _googleMapData = [];
  List<GoogleMapDataStruct> get googleMapData => _googleMapData;
  set googleMapData(List<GoogleMapDataStruct> value) {
    _googleMapData = value;
    prefs.setStringList(
        'ff_googleMapData', value.map((x) => x.serialize()).toList());
  }

  // Plusieurs méthodes pour ajouter, retirer ou mettre à jour des données de carte Google.
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

  // Gestion de l'appareil actuellement sélectionné (AntimoustiqueStruct).
  AntimoustiqueStruct? _currentDevice = null;

  // Méthodes pour gérer l'appareil actuel.
  AntimoustiqueStruct? get currentDevice => _currentDevice;
  set currentDevice(AntimoustiqueStruct? value) {
    _currentDevice = value;
    if (value == null) {
      prefs.remove('ff_currentDevice');
    } else {
      prefs.setString('ff_currentDevice', value.serialize());
    }
    notifyListeners();
  }


  void updateCurrentDeviceStruct(Function(AntimoustiqueStruct) updateFn) {
    updateFn(_currentDevice!);
    prefs.setString('ff_currentDevice', _currentDevice!.serialize());
  }

  // Gestion de la liste des notifications.
  List<NotificationStruct> _notificationList = [];
  List<NotificationStruct> get notificationList => _notificationList;
  set notificationList(List<NotificationStruct> value) {
    _notificationList = value;
    prefs.setStringList(
        'ff_notificationList', value.map((x) => x.serialize()).toList());
  }

  // Plusieurs méthodes pour ajouter, retirer ou mettre à jour des notifications.
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

  void removeNotificationsForDevice(AntimoustiqueStruct device) {
    _notificationList.removeWhere((notification) => notification.antimoustique == device);
    // Sauvegarder la liste mise à jour dans les préférences
    prefs.setStringList('ff_notificationList', _notificationList.map((x) => x.serialize()).toList());
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

// Fonction d'assistance pour exécuter en toute sécurité les initialisations.
void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

// ignore: unused_element
Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
