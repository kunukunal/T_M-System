import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/generated/assets.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitDetailViewWidget {
  pageViewWidget() {
    final unitDetailsCntrl = Get.find<UnitDetailViewController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            width: Get.width,
            decoration: BoxDecoration(
                // color: HexColor('#050505'),
                borderRadius: BorderRadius.circular(10.r)),
            child: Stack(
              children: [
                PageView(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  controller: unitDetailsCntrl.pageController.value,
                  children: [
                    ...List.generate(
                        unitDetailsCntrl.unitImageList.isNotEmpty
                            ? unitDetailsCntrl.unitImageList.length
                            : 1,
                        (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: unitDetailsCntrl.unitImageList.isNotEmpty
                                  ? Image.network(
                                      unitDetailsCntrl.unitImageList[index]
                                          ['image_url'],
                                      height: 350.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/walk_through_image.png",
                                      height: 350.h,
                                      fit: BoxFit.cover,
                                    ),
                            ))
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: SmoothPageIndicator(
                      controller: unitDetailsCntrl.pageController.value,
                      count: unitDetailsCntrl.unitImageList.isNotEmpty
                          ? unitDetailsCntrl.unitImageList.length
                          : 1,
                      effect: SlideEffect(
                          dotWidth: 8.w,
                          dotHeight: 8.h,
                          dotColor: HexColor('#EBEBEB'),
                          activeDotColor: HexColor('#679BF1')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabContent(String text) {
    return Container(
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        text,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      )),
    );
  }

  Widget overViewWidget() {
    final unitCntrl = Get.find<UnitDetailViewController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              unitCntrl.unitData['unit_name'].toString(),
              style: CustomStyles.titleText
                  .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
            ),
            Row(
              children: [
                Text("₹${unitCntrl.unitData['unit_rent'].toString()}"),
                SizedBox(
                  width: 5.w,
                ),
                // SvgPicture.asset("assets/icons/i_icon.svg")
              ],
            )
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/location.png",
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(child: Text(unitCntrl.unitData['unit_address'].toString()))
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/calender.svg",
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                child: Text(unitCntrl.unitData['available_from'].toString()))
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "amenities".tr,
          style: CustomStyles.titleText
              .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 10,
              children: [
                ...List.generate(
                  unitCntrl.amenitiesList.length,
                  (index) {
                    return Row(
                      children: [
                        Image.asset(
                          "assets/icons/tick_icon.png",
                          height: 25.h,
                          width: 25.w,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text(unitCntrl.amenitiesList[index]['name']),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text(
                            "₹ ${unitCntrl.amenitiesList[index]['price']}") // You can use unitCntrl.amenitiesList[index] to dynamically set the text
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
        // GridView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, // Adjust the number of columns as needed
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //     childAspectRatio: 6, // Ensures each item is square
        //   ),
        //   itemCount: unitCntrl.amenitiesList.length,
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     return Row(
        //       children: [
        //         Image.asset(
        //           "assets/icons/tick_icon.png",
        //           height: 25.h,
        //           width: 25.w,
        //         ),
        //         SizedBox(
        //           width: 10.h,
        //         ),
        //         Text(unitCntrl.amenitiesList[index]['name']),
        //         SizedBox(
        //           width: 10.h,
        //         ),
        //         Text(
        //             "₹ ${unitCntrl.amenitiesList[index]['price']}") // You can use unitCntrl.amenitiesList[index] to dynamically set the text
        //       ],
        //     );
        //   },
        // ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                children: [
                  unitCntrl.unitData['lanlord_image'].toString() != ""
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              unitCntrl.unitData['lanlord_image'].toString()))
                      : const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(Assets.iconsProfile),
                        ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unitCntrl.unitData['lanlord_name'].toString(),
                        style: CustomStyles.otpStyle050505W700S16
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text("landlord".tr)
                    ],
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (unitCntrl.unitData['landlord_email']
                            .toString()
                            .isNotEmpty) {
                          try {
                            final nativeUrl = Uri.parse(
                                "mailto:${unitCntrl.unitData['landlord_email']}");
                            if (await canLaunchUrl(nativeUrl)) {
                              await launchUrl(nativeUrl);
                            } else {}
                          } catch (e) {
                            print("sdajkasdj $e");
                          }
                        } else {
                          customSnackBar(Get.context!, "email_not_found".tr);
                        }
                      },
                      child: emailIcon),
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (unitCntrl.unitData['landlord_mobile']
                            .toString()
                            .isNotEmpty) {
                          try {
                            final nativeUrl = Uri.parse(
                                "tel:${unitCntrl.unitData['landlord_mobile']}");
                            if (await canLaunchUrl(nativeUrl)) {
                              await launchUrl(nativeUrl);
                            } else {}
                          } catch (e) {
                            print("sdajkasdj $e");
                          }
                        } else {
                          customSnackBar(
                              Get.context!, "phone_number_not_found".tr);
                        }
                      },
                      child: callIcon)
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: HexColor('#EBEBEB'),
                height: .5,
              ),
              SizedBox(
                height: 10.h,
              ),
              detailInnerWidget('${'phone_number'.tr}     :',
                  '${unitCntrl.unitData['landlord_mobile']}'),
              SizedBox(
                height: 10.h,
              ),
              detailInnerWidget('${'email_address'.tr}      :',
                  '${unitCntrl.unitData['landlord_email']}'),
              SizedBox(
                height: 10.h,
              ),
              detailInnerWidget('${'address'.tr}                :',
                  '${unitCntrl.unitData['landlord_address']}'),
              SizedBox(
                height: 10.h,
              ),
              // detailInnerWidget(
              //     '${'occupied_units'.tr}   :', '${cntrl.occupiedUnit}'),
            ],
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.grey.shade300),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: ListTile(
        //     contentPadding: EdgeInsets.zero,
        //     leading: unitCntrl.unitData['lanlord_image'].toString() != ""
        //         ? CircleAvatar(
        //             radius: 30,
        //             backgroundImage: NetworkImage(
        //                 unitCntrl.unitData['lanlord_image'].toString()))
        //         : const CircleAvatar(
        //             radius: 30,
        //             backgroundImage: AssetImage(Assets.iconsProfile),
        //           ),
        //     title: Text(
        //       unitCntrl.unitData['lanlord_name'].toString(),
        //       style: CustomStyles.titleText
        //           .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        //     ),
        //     subtitle: Text("landlord".tr),
        //   ),
        // ),
        SizedBox(
          height: 10.h,
        ),
        if ((unitCntrl.unitData['lat_long'] as List).isNotEmpty)
          GestureDetector(
            onTap: () async {
              final latitude = (unitCntrl.unitData['lat_long'] as List)[0];
              final longitude = (unitCntrl.unitData['lat_long'] as List)[1];

              try {
                final nativeUrl = Uri.parse(
                    "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
                if (await canLaunchUrl(nativeUrl)) {
                  await launchUrl(nativeUrl);
                } else {}
              } catch (e) {
                print("sdajkasdj $e");
              }
            },
            child: Column(
              children: [
                Image.asset("assets/icons/map.png"),
                // const Text(
                //   "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.",
                //   style: TextStyle(fontSize: 17),
                // )
              ],
            ),
          ),
        SizedBox(
          height: 10.h,
        ),
        Obx(() {
          return unitCntrl.isRequestUnitPlaceOrExit.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : customBorderWithIconButton(
                  unitCntrl.isFromDashboard.value
                      ? unitCntrl.isExitRequest.value
                          ? "request_submitted".tr
                          : "exit_unit".tr
                      : unitCntrl.isPalceRequest.value
                          ? "request_submitted".tr
                          : "request_unit".tr, () {
                  if (unitCntrl.isFromDashboard.value) {
                    if (unitCntrl.isExitRequest.value == false) {
                      unitCntrl.sendUnitExitRequest();
                      // dasds
                    } else {
                      customSnackBar(
                          Get.context!, "request_already_submitted".tr);
                    }
                  } else {
                    if (unitCntrl.isPalceRequest.value == false) {
                      unitCntrl.sendUnitRequest();

                      //fdsa
                    } else {
                      customSnackBar(
                          Get.context!, "request_already_submitted".tr);
                    }
                  }
                },
                  fontweight: FontWeight.w500,
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  color: unitCntrl.isFromDashboard.value
                      ? unitCntrl.isExitRequest.value
                          ? red.withOpacity(0.5)
                          : red
                      : unitCntrl.isPalceRequest.value
                          ? Colors.grey
                          : HexColor('#679BF1'),
                  textColor: HexColor('#FFFFFF'),
                  borderColor: Colors.transparent);
        }),
      ],
    );
  }

  Widget ratingWidget() {
    final unitCntrl = Get.find<UnitDetailViewController>();
    return SingleChildScrollView(
      physics:
          const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/star.svg"),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${unitCntrl.unitRating['overall_average'].toString()} (${unitCntrl.unitRating['total_reviews'].toString()} ${'reviews'.tr})",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              if (unitCntrl.isFromDashboard.value &&
                  unitCntrl.isRatingDone.value == false)
                TextButton(
                  child: Text("${'add_review'.tr}",
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  onPressed: () {
                    // add review
                    for (var unit in unitCntrl.rateUnit) {
                      unit['rating'] = 0.0;
                    }
                    unitCntrl.reviewController.value.clear();
                    showReviewDialog();
                  },
                )
            ],
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            padding: EdgeInsets.only(right: 10.w),
            shrinkWrap: true,
            itemCount: unitCntrl.reviewCategory.length,
            physics:
                const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    unitCntrl.reviewCategory[index]['name'].toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Expanded(child: Divider()),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(unitCntrl.reviewCategory[index]['rating'].toString(),
                      style: const TextStyle(fontSize: 15))
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.h);
            },
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            shrinkWrap: true,

            physics:
                const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
            itemCount: unitCntrl.reviewList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: unitCntrl.reviewList[index]['profile_image'] !=
                            null
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                unitCntrl.reviewList[index]['profile_image']),
                          )
                        : const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(Assets.iconsProfile),
                          ),
                    title: Text(
                      unitCntrl.reviewList[index]['tenant'],
                      style: CustomStyles.titleText.copyWith(
                          fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                    ),
                    subtitle: Text(unitCntrl.reviewList[index]['created_at']),
                  ),
                  Text(
                    unitCntrl.reviewList[index]['review'],
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ],
      ),
    );
  }

  void showReviewDialog() {
    final UnitDetailViewController unitCntrl =
        Get.find<UnitDetailViewController>();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        titlePadding: EdgeInsets.only(top: 15.h, left: 14.w, right: 14.w),
        contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
        title: Text(
          "rate_unit".tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp - commonFontSize,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(unitCntrl.rateUnit.length, (index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          unitCntrl.rateUnit[index]['name'].toString(),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      PannableRatingBar(
                        rate: unitCntrl.rateUnit[index]['rating'] as double,
                        items: List.generate(
                          5,
                          (index) => const RatingWidget(
                            selectedColor: Colors.yellow,
                            unSelectedColor: Colors.grey,
                            child: Icon(
                              Icons.star,
                              size: 30,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          unitCntrl.rateUnit[index]['rating'] = value;
                          unitCntrl.rateUnit.refresh();
                        },
                      ),
                    ],
                  );
                }),
                SizedBox(height: 10.h),
                Text(
                  "write_review".tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp - commonFontSize,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                customTextField(
                    controller: unitCntrl.reviewController.value,
                    hintText: '${'type_here'.tr}...',
                    isBorder: true,
                    isFilled: false,
                    maxLines: 4),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: customBorderButton(
                        "cancel".tr,
                        () {
                          Get.back();
                        },
                        verticalPadding: 5.h,
                        horizontalPadding: 2.w,
                        btnHeight: 35.h,
                        width: 140.w,
                        borderColor: HexColor('#679BF1'),
                        textColor: HexColor('#679BF1'),
                      ),
                    ),
                    Flexible(
                      child: unitCntrl.isReviewSubmitted.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : customBorderButton(
                              "send_review".tr,
                              () {
                                if (unitCntrl.reviewController.value.text
                                    .trim()
                                    .isNotEmpty) {
                                  unitCntrl.sendReview();
                                } else {
                                  customSnackBar(
                                      Get.context!, "please_write_review".tr);
                                }
                                // Handle the update logic here.
                              },
                              verticalPadding: 5.h,
                              horizontalPadding: 2.w,
                              btnHeight: 35.h,
                              width: 140.w,
                              color: HexColor('#679BF1'),
                              borderColor: HexColor('#679BF1'),
                              textColor: whiteColor,
                            ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
      barrierDismissible: false,
    );
  }

  detailInnerWidget(key, value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150.w,
          child: Text(
            key,
            style: CustomStyles.otpStyle050505W400S14,
          ),
        ),
        SizedBox(
          width: 10.h,
        ),
        Expanded(
            child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomStyles.desc606060.copyWith(
              fontSize: 14.sp - commonFontSize, fontFamily: 'DM Sans'),
        )),
      ],
    );
  }
}
