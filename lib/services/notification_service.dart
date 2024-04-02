import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../backend/schema/structs/notification_struct.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // Configuration pour Android
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuration pour iOS
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        // Ici, vous pouvez personnaliser ce que vous voulez faire lorsque la notification est reçue en premier plan
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> sendLocalNotification(NotificationStruct value) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'votre_channel_id', // Assurez-vous que ce channel ID a été créé
      'votre_channel_nom',
      'votre_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // ID de la notification
      value.antimoustique.name, // titre
      value.body, // corps de la notification
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future onSelectNotification(String? payload) async {
    // Ici, gérez ce que vous voulez faire lorsque l'utilisateur sélectionne la notification
  }
}
