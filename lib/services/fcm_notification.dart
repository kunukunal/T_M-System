import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
// inslization of notification
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    initPushNotification();
    try {
      _firebaseMessaging.getToken().then((value) async {
        await SharedPreferencesServices.setStringData(
            key: SharedPreferencesKeysEnum.fcmToken.value, value: value);

        print("fcmToken: $value");
      });
    } catch (e) {}
  }

// handle operation
  void handleMessage(
    RemoteMessage? event,
  ) async {
    print(
        "${event?.data} ${event?.notification?.title} ${event?.notification?.body} ${event?.messageType}");
  }

  // handle selctnotification
  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((event) async {
      handleMessage(event);
      notification(
          Get.context!, event.notification!.title!, event.notification!.body!);
    });
  }
}
