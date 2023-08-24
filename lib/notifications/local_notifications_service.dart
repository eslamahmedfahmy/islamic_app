import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:islam_app/notifications/staticVars.dart';

// //  اضافه اشعارات داخل التطبيق
class NotificationsServices {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('splash');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '$rndmIndex.0',
      'تطبيق الإسلام',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    // ده بيبعت اشعار اول ما اضغط عليه يبعت مره واحده فقط
    await _flutterLocalNotificationsPlugin.show(
      rndmIndex,
      title,
      StaticVars().smallDo3a2[rndmIndex],
      // body,
      notificationDetails,
    );
    //  بيبعت اشعارات كل وقت محداد
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      rndmIndex,
      title,
      StaticVars().smallDo3a2[rndmIndex],
      RepeatInterval.everyMinute, // تكرار الإشعار كل دقيقة
      notificationDetails,
    );
  }

  void stoptNotifications() {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
