import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/screens/onboarding/language/language.dart';
import 'package:tanent_management/screens/profile/contact_us/contact_us_view.dart';
import 'package:tanent_management/screens/profile/documents/document_view.dart';
import 'package:tanent_management/screens/profile/faqs/faqs_view.dart';
import 'package:tanent_management/screens/profile/my_profile/my_profile_widget.dart';
import 'package:tanent_management/screens/profile/notification_setting/notification_view.dart';
import 'package:tanent_management/screens/profile/privacy_policy/privacy_policy_view.dart';

import 'my_profile_controller.dart';

class MyProfileView extends StatelessWidget {
  MyProfileView({super.key});

  final profileCntrl = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyProfileWidget.myProfileContainer(
                    name: 'Bessie Cooper', phoneNo: '+91 7123456891'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    'Settings',
                    style:
                        TextStyle(fontSize: 16.sp - commonFontSize, fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'Documents',
                    onTap: () {
                      Get.to(
                          () => DocumentScreen(
                                isFromTenant: false,
                              ),
                          arguments: [false, 0]);
                    },
                    image: 'assets/icons/Group 26.png'),
                MyProfileWidget.commonListTile(
                    title: 'Tenants Rent',
                    onTap: () {},
                    image: 'assets/icons/ic-bank.png'),
                MyProfileWidget.commonListTile(
                    title: 'Language',
                    onTap: () {
                      Get.to(
                        () => LanguageScreen(
                          isFromProfile: true,
                        ),
                      );
                    },
                    image: 'assets/icons/language.png'),
                MyProfileWidget.commonListTile(
                    title: 'Notifications',
                    onTap: () {
                      Get.to(() => NotificationView());
                    },
                    image: 'assets/icons/ic-notification.png'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    'About Us',
                    style:
                        TextStyle(fontSize: 16.sp - commonFontSize, fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'FAQ',
                    onTap: () {
                      Get.to(() => FAQsView());
                    },
                    image: 'assets/icons/faq.png'),
                MyProfileWidget.commonListTile(
                    title: 'Privacy Policy',
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen());
                    },
                    image: 'assets/icons/ic-security.png'),
                MyProfileWidget.commonListTile(
                    title: 'Contact Us',
                    onTap: () {
                      Get.to(() => ContactUsScreen());
                    },
                    image: 'assets/icons/ic-support.png'),
                // MyProfileWidget.commonListTile(
                //     title: 'Profile',
                //     onTap: () {
                //       Get.to(() => DocumentScreen(
                //             isFromTenant: false,
                //           ));
                //     },
                //     image: 'assets/icons/Group 26.png'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    'Other',
                    style:
                        TextStyle(fontSize: 16.sp - commonFontSize, fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'Share',
                    onTap: () {},
                    image: 'assets/icons/ic-share.png'),
                MyProfileWidget.commonListTile(
                    title: 'Logout',
                    onTap: () {
                      resgisterPopup(
                        title: 'Logout',
                        subtitle: 'Are you sure you want to log out?',
                        button1: 'Cancel',
                        button2: 'Yes, Logout',
                        onButton1Tap: () {
                          Get.back();
                        },
                        onButton2Tap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.remove("access_token");
                          Get.deleteAll();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignInScreen(isFromRegister: false),
                              ),
                              (route) => false);
                          // Get.offAll(() => SignInScreen(isFromRegister: false));
                        },
                      );
                    },
                    image: 'assets/icons/ic-logout.png'),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
