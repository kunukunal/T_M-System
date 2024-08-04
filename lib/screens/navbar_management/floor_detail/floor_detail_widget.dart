import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/management/management_widgets.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/unit_history.dart';
import 'package:tanent_management/screens/profile/edit_profile/edit_profile_widget.dart';

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
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: lightBorderGrey)),
        child: Slidable(
          key: UniqueKey(),
          endActionPane: isOccupied == true
              ? ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    //

                    SlidableAction(
                      onPressed: (context) {
                        floorCntrl.rentTo.value = null;
                        exitTenant(
                            button1: "No",
                            button2: "Yes",
                            onButton1Tap: () {
                              Get.back();
                            },
                            onButton2Tap: () {
                              if (floorCntrl.rentTo.value != null) {
                                Get.back();
                                floorCntrl.removeTenant(unitId!);
                              } else {
                                customSnackBar(Get.context!,
                                    "Please choose the unit exit date");
                              }
                            },
                            title:
                                "Are you sure you want to remove the tenant?");
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: whiteColor,
                      icon: Icons.exit_to_app,
                      label: "Exit Tenant",
                    ),
                  ],
                )
              : null,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 80.h,
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
                                      fontSize: 14.sp - commonFontSize,
                                      color: black),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  price!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp - commonFontSize,
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
                                                '$availablityTitle',
                                                style: TextStyle(
                                                  color: red,
                                                  fontSize:
                                                      12.sp - commonFontSize,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                tenantName ?? "",
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize:
                                                        12.sp - commonFontSize),
                                              )
                                            ],
                                          ),
                                        )
                                      : FittedBox(
                                          child: Text(
                                            availablityTitle ?? "Available",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    12.sp - commonFontSize,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(120.w, 25.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: isOccupied == true
                                        ?HexColor("#ed6d6d")
                                        : Color.fromARGB(255, 33, 194, 243)),
                                onPressed: () {
                                  if (isOccupied == false) {
                                    floorCntrl.onBuildingTap(
                                        {"id": unitId, "name": unitTitle},
                                        amenities!,
                                        {
                                          'isNegiosiate':
                                              floorCntrl.items[index!]
                                                  ['is_rent_negotiable'],
                                          'ammount': floorCntrl.items[index]
                                              ['unit_rent']
                                        });
                                  } else {
                                    customSnackBar(Get.context!,
                                        "Unit is already occupied, cannot add tenant");
                                  }
                                },
                                child: Text(
                                  isOccupied == true ? "Booked" : "Book Now",
                                  style: const TextStyle(color: Colors.white),
                                )),
                          )
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
              //               fontSize: 14.sp - commonFontSize,
              //               color: grey),
              //         ),
              //         Text(
              //           'Building $building    ',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14.sp - commonFontSize,
              //               color: grey),
              //         ),
              //         Text(
              //           'Floor $floor    ',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: 14.sp - commonFontSize,
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

  exitTenant({
    required String title,
    required String button1,
    required String button2,
    required Function() onButton1Tap,
    required Function() onButton2Tap,
  }) async {
    final floorCntrl = Get.find<FloorDetailController>();

    Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp - commonFontSize,
                                fontWeight: FontWeight.w700)),
                      ),
                      EditProfileWidget.commomText('Exit date'),
                      Obx(() {
                        return ManagementWidgets().datePickerContainer(
                            floorCntrl.rentTo.value == null
                                ? 'Select'
                                : '${floorCntrl.rentTo.value!.day}-${floorCntrl.rentTo.value!.month}-${floorCntrl.rentTo.value!.year}',
                            onTap: () {
                          floorCntrl.selectDateTo(Get.context!);
                        });
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(button1, onButton1Tap,
                              verticalPadding: 5.h,
                              horizontalPadding: 2.w,
                              btnHeight: 35.h,
                              width: 140.w,
                              borderColor: HexColor('#679BF1'),
                              textColor: HexColor('#679BF1')),
                          customBorderButton(
                            button2,
                            onButton2Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
