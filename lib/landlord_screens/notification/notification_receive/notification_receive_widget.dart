import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_controller.dart';

import '../../../common/constants.dart';
import '../../../common/widgets.dart';

class NotifReceiveWidget{
  notifReceiveList(
      {
        String? transactionId,
        String? title,
        String? desc,
        String? price,
        String? name,
        String? date,
      }) {
    final notifReceiveCntrl = Get.find<NotifReceiveController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h,top: 10.h),
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: lightBorderGrey)),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transaction ID',
                style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp - commonFontSize, color: black),
              ),

              Text(transactionId!,style: TextStyle(fontSize: 12.sp - commonFontSize,fontWeight: FontWeight.w400,color: grey),),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: HexColor('#EBEBEB'),
                height: 1.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: Row(
                  children: [
                    recieveNotif,
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title!,
                                  style:
                                  TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp - commonFontSize, color: black),
                                ),
                              ),
                              Text(
                                price!,

                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp - commonFontSize,
                                    color: red),
                              ),
                            ],
                          ),

                          Text(
                            desc!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp - commonFontSize,
                                color: grey),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: HexColor('#EBEBEB'),
                height: 1.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name: ',

                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp - commonFontSize,
                            color: grey),
                      ),
                      Text(
                        name!,

                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp - commonFontSize,
                            color: grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Date: ',

                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp - commonFontSize,
                            color: grey),
                      ),
                      Text(
                        date!,

                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp - commonFontSize,
                            color: grey),
                      ),
                    ],
                  )
                ],
              ),
              customBorderButton('Edit', () {
notifReceiveCntrl.onEditTap();
              },
                  verticalPadding: 12.h,
                  horizontalPadding: 2.w,
                  btnHeight: 30.h,
                  width:Get.width,
                  borderColor: HexColor('#679BF1'),
                  textColor: HexColor('#679BF1'))

            ],
          ),
        ),
      ),
    );
  }

  declinePopup(){
    return   commonDeclinePopup(
      title: '',
      subtitle: 'Are you sure you want to decline this request?',
      button1: 'Decline',
      button2: 'Not, Received',
      onButton1Tap: () {
        Get.back();


      },
      onButton2Tap: (){
        Get.back();


      },
    );
  }
}