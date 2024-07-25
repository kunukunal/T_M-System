import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/unit_history.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class FloorDetailWidget {
  appBar() {
    return AppBar(
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
      title: Text('Building A - Floor 1',
          style: CustomStyles.otpStyle050505W700S16),
    );
  }

  unitList({
    int? index,
    String? unitTitle,
    String? price,
    String? availablityTitle,
    String? icon,
    String? buildingIcon,
    String? tenantName,
    bool? isOccupied,
    List? amenities,
    int? unitId,
  }) {
    final floorCntrl = Get.find<FloorDetailController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          if (isOccupied == false) {
            floorCntrl.onBuildingTap(
                {"id": unitId, "name": unitTitle},
                amenities!,
                {
                  'isNegiosiate': floorCntrl.items[index!]
                      ['is_rent_negotiable'],
                  'ammount': floorCntrl.items[index]['unit_rent']
                });
          } else {
            customSnackBar(
                Get.context!, "Unit is already occupied, cannot add tenant");
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
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
                          borderRadius: BorderRadius.circular(10.r),
                          image: buildingIcon != null
                              ? DecorationImage(
                                  image: NetworkImage(buildingIcon),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage("assets/icons/a.png"),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  unitTitle!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color: black),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  price!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      color: black),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Image.asset(
                                    icon!,
                                    height: 23.h,
                                    width: isOccupied! ? 25.w : 20.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  isOccupied
                                      ? Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Occupied From $availablityTitle',
                                                style: TextStyle(
                                                  color: red,
                                                  fontSize: 12.sp,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                tenantName ?? "",
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 12.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      : FittedBox(
                                          child: Text(
                                            'Available From ${availablityTitle ?? ""}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                                color: green),
                                          ),
                                        ),
                                ]),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => UnitHistory(),
                                          arguments: [unitId]);
                                    },
                                    child: Image.asset(
                                      'assets/icons/timer.png',
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (isOccupied == false)
                                    Image.asset(
                                      'assets/icons/Frame.png',
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: HexColor('#EBEBEB'),
              //   height: 1.h,
              // ),
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 10.w),
              //     child: Row(
              //       children: [
              //         Text(
              //           'Property $property    ',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14.sp,
              //               color: grey),
              //         ),
              //         Text(
              //           'Building $building    ',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14.sp,
              //               color: grey),
              //         ),
              //         Text(
              //           'Floor $floor    ',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14.sp,
              //               color: grey),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
