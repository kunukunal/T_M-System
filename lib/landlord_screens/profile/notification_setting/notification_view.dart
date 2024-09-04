import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/landlord_screens/profile/notification_setting/notification_controller.dart';
import 'package:tanent_management/landlord_screens/profile/notification_setting/notification_widgets.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final notifCntrl = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('notification_settings'.tr, style: CustomStyles.otpStyle050505),
        actions: [
          GestureDetector(
            onTap: () {
              notifCntrl.updateNotificationSetting();
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: tick,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return notifCntrl.notificationSettingLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  children: [
                    NotifWidget.commonListTile(
                        title: 'general_notification'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForGenNotif.value,
                        onChanged: (value) {
                          notifCntrl.switchForGenNotif.value = value;
                        }),
                    NotifWidget.commonListTile(
                        title: 'sounds'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForSound.value,
                        onChanged: (value) {
                          notifCntrl.switchForSound.value = value;
                        }),
                    NotifWidget.commonListTile(
                        title: 'payments'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForPayment.value,
                        onChanged: (value) {
                          notifCntrl.switchForPayment.value = value;
                        }),
                    NotifWidget.commonListTile(
                        title: 'any_updates'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForAnyUpdate.value,
                        onChanged: (value) {
                          notifCntrl.switchForAnyUpdate.value = value;
                        }),
                    NotifWidget.commonListTile(
                        title: 'email_notification'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForEmailNotif.value,
                        onChanged: (value) {
                          if (userData['email_verified'] == true) {
                            notifCntrl.switchForEmailNotif.value = value;
                          } else {
                            NotifWidget().showEmailDialoge(
                                title: "email_notification".tr,
                                button1: "cancel".tr,
                                button2: "send_via_otp".tr);
                          }
                        }),
                    NotifWidget.commonListTile(
                        title: 'new_services_available'.tr,
                        onTap: () {},
                        switchValueForNotification:
                            notifCntrl.switchForNewService.value,
                        onChanged: (value) {
                          notifCntrl.switchForNewService.value = value;
                        }),
                    NotifWidget.commonListTile(
                        title: 'new_tips_available'.tr,
                        switchValueForNotification:
                            notifCntrl.switchForNewTip.value,
                        onTap: () {},
                        onChanged: (value) {
                          notifCntrl.switchForNewTip.value = value;
                        }),
                  ],
                ),
            );
      }),
    );
  }
}
