import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/profile/notification_setting/notification_controller.dart';
import 'package:tanent_management/screens/profile/notification_setting/notification_widgets.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class NotificationView extends StatelessWidget {
   NotificationView({super.key});

   final notifCntrl = Get.put(NotificationController());

   @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings', style: CustomStyles.otpStyle050505),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child:tick ,
          ),

        ],
      ),
      body: Column(children: [
        NotifWidget.commonListTile(
            title: 'General Notification',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForGenNotif.value=value;
            }
        ),
        NotifWidget.commonListTile(
            title: 'Sounds',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForSound.value=value;
            }

        ),

        NotifWidget.commonListTile(
            title: 'Payments',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForPayment.value=value;
            }

        ),
        NotifWidget.commonListTile(
            title: 'Any Updates',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForAnyUpdate.value=value;
            }

        ),
        NotifWidget.commonListTile(
            title: 'Email Notification',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForEmailNotif.value=value;
            }

        ),
        NotifWidget.commonListTile(
            title: 'New Services Available',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForNewService.value=value;
            }

        ),
        NotifWidget.commonListTile(
            title: 'New Tips Available',
            onTap: () {},
            onChanged: (value){
              notifCntrl.switchForNewTip.value=value;
            }

        ),





      ],),
    ));
  }
}
