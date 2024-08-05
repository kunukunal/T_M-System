import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/my_profile/my_profile_controller.dart';

import '../../../common/constants.dart';

class MyProfileWidget {
  static myProfileContainer({String? name, String? phoneNo, String? image}) {
    final profileCntrl = Get.find<MyProfileController>();

    return Stack(
      children: [
        Container(
          height: 215.h,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset('assets/icons/my_profile.png').image,
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: backArrowImageWhite),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'My Profile',
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp - commonFontSize),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 120.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: HexColor('#444444'),
                    shape: BoxShape.circle,
                    image: image != ""
                        ? DecorationImage(
                            image: NetworkImage(image!), fit: BoxFit.cover)
                        : DecorationImage(
                            image:
                                Image.asset('assets/icons/profile.png').image,
                            fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp - commonFontSize,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      phoneNo!,
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp - commonFontSize,
                          fontFamily: 'Inter'),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  profileCntrl.onEditProfileTap(true);
                },
                child: Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: HexColor('#FFFFFF').withOpacity(.15),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 14.sp - commonFontSize,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  static commonListTile(
      {String? title, void Function()? onTap, String? image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      child: ListTile(
          tileColor:title == 'Delete account'? red: whiteColor,
          leading: title == 'Delete account'? Icon(Icons.delete_forever_outlined, color: Colors.white,):Image.asset(
            image!,
            height: 24.h,
            width: 24.w,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: borderGrey)),
          title: Text(
            title!,
            style: TextStyle(
                fontSize: 14.sp - commonFontSize,
                fontWeight: FontWeight.w500,
                color:title == 'Delete account'? whiteColor: HexColor('#050505')),
          ),
          onTap: onTap),
    );
  }
}
