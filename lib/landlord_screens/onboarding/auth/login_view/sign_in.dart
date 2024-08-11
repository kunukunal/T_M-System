import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
              ? "Register as ${authCntrl.onButtonTapTenant.value == 2 ? "Tenant" : "Landlord"}"
              : "Login",
          isBack: false),
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
          isFromRegister! ? const SizedBox() : AuthWidget.registrationBox()
        ],
      ),
    );
  }
}
