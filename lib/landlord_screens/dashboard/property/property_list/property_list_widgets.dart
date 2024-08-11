import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_list/property_list_controller.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';

class PropertyWidget {
  appBar() {
    // final propertyCntrl = Get.find<PropertyListController>();

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
      title: Text('Property List', style: CustomStyles.otpStyle050505W700S16),
      actions: [
        // InkWell(
        //     onTap: () {
        //       propertyCntrl.onAddTap();
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.all(8.r),
        //       child: addIcon,
        //     )),
      ],
    );
  }

  unitList({
    int? propertyIndex,
    int? id,
    String? propertyTitle,
    String? location,
    // String? icon,
    List? buildingIcon,
    // bool? isFeature,
  }) {
    final propertyCntrl = Get.find<PropertyListController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          propertyCntrl.onItemTap(id: id!, propertyTitle: propertyTitle);
        },
        child: Container(
          // height: 114.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    propertyCntrl
                        .onEditTap(propertyCntrl.propertyList[propertyIndex!]);
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: whiteColor,
                  icon: Icons.edit,
                ),

                //

                SlidableAction(
                  onPressed: (context) {
                    deleteFloorPopup(
                        button1: "No",
                        button2: "Yes",
                        onButton1Tap: () {
                          Get.back();
                        },
                        onButton2Tap: () {
                          Get.back();
                          propertyCntrl.deletePropertyData(propertyId: id!);
                        },
                        title:
                            "Are you sure you want to Permanent remove $propertyTitle");
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: whiteColor,
                  icon: Icons.cancel,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: HexColor('#444444'),
                        borderRadius: BorderRadius.circular(10.r),
                        image: buildingIcon!.isEmpty
                            ? DecorationImage(
                                image: Image.asset(
                                        "assets/images/apartment1_image.png")
                                    .image,
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(buildingIcon[0]['image']!),
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          propertyTitle!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp - commonFontSize,
                              color: black),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        // Row(
                        //   children: [
                        //     featureRentContainer(
                        //         isFeatured: true, title: 'Featured'),
                        //     featureRentContainer(
                        //         isFeatured: false, title: 'For Rent'),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10.w,
                        // ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/location.png",
                              height: 23.h,
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Text(
                                location!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp - commonFontSize,
                                    color: black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  featureRentContainer({bool? isFeatured, String? title}) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        height: 25.h,
        width: 90.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border:
                Border.all(color: isFeatured! ? lightBlue : lightBorderGrey)),
        child: Center(
            child: Text(
          title!,
          style: TextStyle(
              fontSize: 12.sp - commonFontSize, color: black, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
