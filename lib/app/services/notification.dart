import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin localNotification =
    FlutterLocalNotificationsPlugin();

initMessaging() {
  var androidInit = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var iosInit = const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );
  var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);
  localNotification.initialize(initSetting);
  var androidDetails = AndroidNotificationDetails(
    "1",
    "chandransteels",
    importance: Importance.high,
    playSound: true,
    priority: Priority.high,
    visibility: NotificationVisibility.public,
    icon: "@mipmap/ic_launcher",
  );

  var iosDetails = DarwinNotificationDetails();

  var generalNotification =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
  FirebaseMessaging.onMessage.listen(
    (event) {
      var notification = event.notification;
      var androidNotification = event.notification?.android;
      if (notification != null && androidNotification != null) {
        localNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotification,
            payload: 'Default_Sound');
      }
    },
  );
}
