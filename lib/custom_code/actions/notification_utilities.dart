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

// Génère des notifications basées sur l'état de l'appareil.
Future<void> generateNotification() async {
  try {
    // Vérifie séparément pour chaque type de notification
    await _checkAndAddCo2LowNotification();
    await _checkAndAddAttractifLowNotification();
  } catch (e) {
    print("Erreur lors de la génération des notifications : $e");
  }
}

// Vérifie le niveau de CO2 et ajoute une notification si nécessaire.
Future<void> _checkAndAddCo2LowNotification() async {
  try {
    // Vérifiez d'abord si currentDevice est non-null.
    var currentDevice = FFAppState().currentDevice;
    if (currentDevice == null) {
      print("Current device is null, cannot check CO2 level.");
      return;
    }

    // Vérifiez si la notification CO2 est déjà dans la liste.
    bool isCo2NotificationAlreadyInList = FFAppState().notificationList.any(
          (notification) => notification.antimoustique == currentDevice && notification.type == NotificationType.co2Low,
        );

    // Vérifiez maintenant si le niveau de CO2 est bas et s'il n'y a pas déjà une notification.
    if (currentDevice.islevelCo2Low() && !isCo2NotificationAlreadyInList) {
      NotificationStruct notification = NotificationStruct(
        antimoustique: currentDevice, // Utilisation de la variable locale non-nulle.
        title: "",
        body: "Niveau de CO2 faible, veuillez changer la bouteille.",
        type: NotificationType.co2Low,
      );
      FFAppState().addToNotificationList(notification);
    }
  } catch (e) {
    print("Erreur lors de la vérification/ajout de la notification de CO2 : $e");
  }
}

// Vérifie le niveau d'attractif et ajoute une notification si nécessaire.
Future<void> _checkAndAddAttractifLowNotification() async {
  try {
    // Vérifiez d'abord si currentDevice est non-null.
    var currentDevice = FFAppState().currentDevice;
    if (currentDevice == null) {
      print("Current device is null, cannot check Attractif level.");
      return;
    }
    bool isAttractifNotificationAlreadyInList = FFAppState().notificationList.any(
          (notification) => notification.antimoustique == FFAppState().currentDevice && notification.type == NotificationType.attractifLow,
        );

    if (currentDevice.islevelAttractifLow() && !isAttractifNotificationAlreadyInList) {
      NotificationStruct notification = NotificationStruct(
        antimoustique: FFAppState().currentDevice,
        title: "Avertissement Attractif",
        body: "Niveau d'attractif faible, veuillez le recharger.",
        type: NotificationType.attractifLow,
      );
      FFAppState().addToNotificationList(notification);
    }
  } catch (e) {
    print("Erreur lors de la vérification/ajout de la notification d'attractif : $e");
  }
}