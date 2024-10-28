import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/landlord_screens/navbar/nav_bar_controller.dart';

import '../../common/text_styles.dart';

class NavBarWidgets {
  //NavBar
  static Widget buildNavItem(int index, String icon, String name,
      {Color? color}) {
    final dashboardCntrl = Get.put(NavBarController());
    return Obx(() {
      return GestureDetector(
        onTap: () => dashboardCntrl.onItemTap(index),
        child: Column(
          children: [
            Container(
                width: Get.width / 5,
                height: 2.h,
                color: index == dashboardCntrl.selectedIndex.value
                    ? HexColor('#679BF1')
                    : Colors.transparent),
            Container(
              height: 38.h,
              width: 40.5.w,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.r)),
              child: Image.asset(
                icon,
                height: 23.h,
                width: 26.w,
                color: color,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              name,
              style: CustomStyles.blue679BF1.copyWith(
                  color: index == dashboardCntrl.selectedIndex.value
                      ? HexColor('#679BF1')
                      : HexColor('#606060')),
            )
          ],
        ),
      );
    });
  }
}
