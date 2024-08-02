import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tanent_management/screens/onboarding/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Initialize flutter_screen_util
    return ScreenUtilInit(
      builder: (context, child) {
        return OverlaySupport.global(
          child: GetMaterialApp(
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
      }
    );
  }
}