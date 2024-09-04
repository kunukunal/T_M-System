import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/firebase_options.dart';
import 'package:tanent_management/landlord_screens/onboarding/splash/splash.dart';
import 'package:tanent_management/landlord_screens/onboarding/language/locale/locale.dart';
import 'package:tanent_management/services/fcm_notification.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService().handleMessage(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotifications();
  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode =
      prefs.getString(SharedPreferencesKeysEnum.languaecode.value);
  Locale? locale;
  if (languageCode != null) {
    locale = Locale(languageCode);
  }
  runApp(MyApp(
    locale: locale,
  ));
}

class MyApp extends StatelessWidget {
  final Locale? locale;

  const MyApp({super.key, this.locale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Initialize flutter_screen_util
    return ScreenUtilInit(builder: (context, child) {
      return OverlaySupport.global(
        child: GetMaterialApp(
          translations: LocaleFile(),
          locale: locale ?? Get.deviceLocale,
          fallbackLocale:
              const Locale('en', 'US'), // Fallback language in case of failure
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'ES'),
            // Add other supported locales here
          ],
          debugShowCheckedModeBanner: false,
          title: 'Tenant Management',
          theme: ThemeData(
            fontFamily: 'DM Sans',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      );
    });
  }
}
