import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/management/management_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_controller.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class SearchWidget {
  appBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      centerTitle: true,
      title: Text('search'.tr, style: CustomStyles.otpStyle050505W700S16),
    );
  }

  //Occupied Container
  occUnoccContainer({
    String? icon,
    String? titleUnit,
    String? units,
    bool isCheckBoxShow = false,
    bool? checkBoxVal,
    Function(bool? val)? onChange,
    Function()? ontap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          // width: Get.width / 2.9,
          // constraints: BoxConstraints(minWidth:150.w, ),
          // height: isCheckBoxShow ? 120.h : 95.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
                child: Row(
                  children: [
                    Image.asset(
                      icon!,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        titleUnit!,
                        style: TextStyle(
                            fontSize: 14.sp - commonFontSize, color: black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (isCheckBoxShow)
                      Checkbox(
                        value: checkBoxVal,
                        onChanged: onChange,
                      )
                  ],
                ),
              ),
              Divider(
                color: lightBorderGrey,
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Text(
                  units!,
                  style: TextStyle(
                      fontSize: 20.sp - commonFontSize,
                      color: black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  unitList(
      {String? unitTitle,
      String? price,
      String? availablityTitle,
      String? lastOccoupiedDate,
      String? buildingIcon,
      String? propertyid,
      String? buildingid,
      String? floorid,
      int? unitId,
      String? property,
      String? building,
      bool? isrentnegotiable,
      String? floor,
      String? tenant,
      bool? isOccupied,
      List? amenities}) {
    final searchCntl = Get.find<SearchCntroller>();

    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          if (isOccupied == false) {
            Get.to(() => ManagementScreen(isFromDashboard: false), arguments: [
              false,
              [
                {"id": int.parse(propertyid!), "name": property},
                {"id": int.parse(buildingid!), "name": building},
                {"id": int.parse(floorid!), "name": floor},
                {"id": unitId, "name": unitTitle},
              ],
              amenities,
              {"isNegiosiate": isrentnegotiable, "ammount": price}
            ])!
                .then((value) {
              if (value == true) {
                searchCntl.getUnitBySearch();
              }
            });
          } else {
            customSnackBar(Get.context!, "unit_already_occupied".tr);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: lightBorderGrey),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 55.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: HexColor('#444444'),
                          image: buildingIcon == null
                              ? const DecorationImage(
                                  image: AssetImage('assets/icons/a.png'),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(buildingIcon),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  unitTitle ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp - commonFontSize,
                                    color: black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '₹$price',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp - commonFontSize,
                                  color: black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/homeIcon.png',
                                height: 23.h,
                                width: isOccupied! ? 25.w : 20.w,
                              ),
                              SizedBox(width: 5.w),
                              isOccupied
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lastOccoupiedDate!,
                                          style: TextStyle(
                                            color: red,
                                            fontSize: 12.sp - commonFontSize,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          tenant ?? "",
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 12.sp - commonFontSize,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      availablityTitle!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp - commonFontSize,
                                        color: green,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        shareUnitById(unitId!);
                      },
                      child: Image.asset(
                        'assets/icons/Frame.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: HexColor('#EBEBEB'), height: 5.h),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "$property | $building | $floor",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: CustomStyles.blue679BF1w700s20.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      fontFamily: 'Inter'),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Expanded(
                //       child: Text(
                //         '${'property'.tr} $property',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //           fontSize: 14.sp - commonFontSize,
                //           color: grey,
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     SizedBox(width: 5.w),
                //     Expanded(
                //       child: Text(
                //         '${'building'.tr} $building',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //           fontSize: 14.sp - commonFontSize,
                //           color: grey,
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     SizedBox(width: 5.w),
                //     Expanded(
                //       child: Text(
                //         '${'floor'.tr} $floor',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //           fontSize: 14.sp - commonFontSize,
                //           color: grey,
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
