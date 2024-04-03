import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import '../backend/schema/structs/notification_struct.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body,
            String? payload) async {
          // Handle foreground notification reception in iOS
        });
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<void> sendLocalNotification(NotificationStruct value) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, // Dynamic ID for the notification
        value.antimoustique.name,
        value.body,
        platformChannelSpecifics,
        payload: value.antimoustique.vendor);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    String? payload = response.payload;
    print(payload);
    if (payload != null) {
      if (payload == "Distributeur" || payload == "unknown") {
        final url = Uri.parse(
            'https://www.google.com/maps/d/viewer?mid=1G4QNa9Ob5ErrTV54evRI3o_Gbm0&hl=en_US&ll=46.14750807696509%2C-71.90924343517304&z=8');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      } else if (payload == "Pole-Habitat") {
        final url = Uri.parse('https://www.pole-habitat-ra.com');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      }
    }
  }
}

