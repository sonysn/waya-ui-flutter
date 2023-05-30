import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      {required String dataTitle, required String dataBody}) async {
    //This variable is used to allow getures on multiline notifications
    var bigTextStyleInformation = BigTextStyleInformation(dataBody);
    //for android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'New Notification', // The title of the notification
            'Shows a notification when new data is received',
            // The description of the notification
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            styleInformation: bigTextStyleInformation);

    //for ios
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            subtitle: 'Shows a notification when new data is received',
            sound: 'default',
            badgeNumber: 1);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, dataTitle, dataBody, platformChannelSpecifics,
        payload: 'new_notification');
  }
}
