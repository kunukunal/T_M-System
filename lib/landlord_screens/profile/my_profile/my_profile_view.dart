import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_view.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/landlord_screens/onboarding/language/language.dart';
import 'package:tanent_management/landlord_screens/profile/contact_us/contact_us_view.dart';
import 'package:tanent_management/landlord_screens/profile/documents/document_view.dart';
import 'package:tanent_management/landlord_screens/profile/faqs/faqs_view.dart';
import 'package:tanent_management/landlord_screens/profile/my_profile/my_profile_widget.dart';
import 'package:tanent_management/landlord_screens/profile/notification_setting/notification_view.dart';
import 'package:tanent_management/landlord_screens/profile/privacy_policy/privacy_policy_view.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

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
                    name: userData['name'] ?? "user".tr,
                    phoneNo:
                        '${userData['phone_code'] ?? ""} ${userData['phone'] ?? ""}',
                    image: userData['profile_image'] ?? ""),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    'settings'.tr,
                    style: TextStyle(
                        fontSize: 16.sp - commonFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'documents'.tr,
                    onTap: () {
                      if (userData['user_type'] == 1) {
                        Get.to(
                            () => DocumentScreen(
                                  isFromTenant: false,
                                ),
                            arguments: [false, userData['id'], true]);
                      } else if (userData['user_type'] == 2) {
                        Get.to(
                            () => DocumentScreen(
                                  isFromTenant: false,
                                ),
                            arguments: [false, userData['id'], false]);
                      }
                    },
                    image: 'assets/icons/Group 26.png'),

                userData['user_type'] == 1
                    ? MyProfileWidget.commonListTile(
                        title: "Payments",
                        onTap: () {
                          Get.to(() => NotificationReceiveView());
                        },
                        image: 'assets/icons/ic-bank.png')
                    : const SizedBox(),
                MyProfileWidget.commonListTile(
                    title: 'language'.tr,
                    onTap: () {
                      Get.to(
                        () => LanguageScreen(
                          isFromProfile: true,
                        ),
                      );
                    },
                    image: 'assets/icons/language.png'),
                MyProfileWidget.commonListTile(
                    title: 'notifications'.tr,
                    onTap: () {
                      Get.to(() => NotificationView());
                    },
                    image: 'assets/icons/ic-notification.png'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    'about_us'.tr,
                    style: TextStyle(
                        fontSize: 16.sp - commonFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'faq'.tr,
                    onTap: () {
                      Get.to(() => FAQsView());
                    },
                    image: 'assets/icons/faq.png'),
                MyProfileWidget.commonListTile(
                    title: 'privacy_policy'.tr,
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen());
                    },
                    image: 'assets/icons/ic-security.png'),
                MyProfileWidget.commonListTile(
                    title: 'contact_us'.tr,
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
                    style: TextStyle(
                        fontSize: 16.sp - commonFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                MyProfileWidget.commonListTile(
                    title: 'share'.tr,
                    onTap: () {},
                    image: 'assets/icons/ic-share.png'),

                MyProfileWidget.commonListTile(
                    title: 'logout'.tr,
                    onTap: () {
                      resgisterPopup(
                        title: 'logout'.tr,
                        subtitle: 'are_you_sure_logout'.tr,
                        button1: 'cancel'.tr,
                        button2: 'yes_logout'.tr,
                        onButton1Tap: () {
                          Get.back();
                        },
                        onButton2Tap: () async {
                          await SharedPreferencesServices.clearSharedPrefData();
                          Get.deleteAll();
                          clearAll();

                          // prefs.setBool('first_run', false);

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
                MyProfileWidget.commonListTile(
                    isDelete: true,
                    title: 'delete_account'.tr,
                    onTap: () {},
                    image: null),
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
