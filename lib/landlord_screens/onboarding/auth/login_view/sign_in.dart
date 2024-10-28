import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';

import 'auth_widgets.dart';

class SignInScreen extends StatelessWidget {
  final bool? isFromRegister;
  final bool? isFrstTime;
  SignInScreen({required this.isFromRegister, this.isFrstTime, super.key});

  final authCntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          title: isFromRegister!
              ? "${'register_as'.tr} ${authCntrl.onButtonTapTenant.value == 2 ? "tenant".tr : "landlord".tr}"
              : "Login",
          isBack: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'Help') {
                  AuthWidget().showHelpDialog(context);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Help',
                  child: Text('Help'),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            )
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 90.h, bottom: 30.h, right: 50.w, left: 50.w),
              child: Image.asset(
                "assets/images/splash_image.png",
                width: 220.w,
              ),
            ),
          ),
          AuthWidget.loginForm(isFromRegister!),
          isFromRegister! ? const SizedBox() : AuthWidget.registrationBox(),
          if (isFromRegister == false)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Version: $appVersion"),
            )
        ],
      ),
    );
  }
}
