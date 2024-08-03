import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/notification_setting/notification_controller.dart';

import '../../../common/constants.dart';

class NotifWidget{
  final notifCntrl = Get.find<NotificationController>();


  static commonListTile({String? title,void Function()? onTap,String? image,bool?switchValueForNotification=false , void Function(bool)? onChanged}){
    return  ListTile(
      visualDensity: VisualDensity(vertical: 3),
        tileColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: borderGrey)
        ),
        trailing:  Switch(
          activeColor: HexColor('#ffffff'),
          inactiveTrackColor: switchGrey,
          activeTrackColor: lightBlue,
          value: switchValueForNotification!,
          onChanged: onChanged
        ),
        title: Text(title!,style: TextStyle(fontSize: 16.sp - commonFontSize,fontWeight: FontWeight.w500,color: HexColor('#050505')),),
        onTap: onTap
    );}
}