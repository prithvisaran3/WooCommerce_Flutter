import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin fltNotification =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;
//notification settings
void initMessaging() async {
  var androidInit =
      const AndroidInitializationSettings("@mipmap/ic_launcher"); //for logo
  var iosInit = const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );
  var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);
  fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(initSetting);
  var androidDetails = const AndroidNotificationDetails("3", "channel 3",
      importance: Importance.max,
      priority: Priority.max,
      visibility: NotificationVisibility.public,
      icon: "@mipmap/ic_launcher",
      playSound: true,
      sound: RawResourceAndroidNotificationSound('tone'));
  var iosDetails = const DarwinNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
  NotificationSettings settings = await messaging.requestPermission();
  print("permission status : ${settings.authorizationStatus}");
  print("lklkjkljlm Message ${FirebaseMessaging.onMessage.listen((event) {
    print(event.notification!.title);
  })}");
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // startMessage();

        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails,
            payload: 'Custom_Sound');
      } else if (notification != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails,
            payload: 'Custom_Sound');
      } else {
        print("error on notification");
      }
    },
    onDone: () {
      print("lkhklhjklhjklghjkgkjgjk");
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}
