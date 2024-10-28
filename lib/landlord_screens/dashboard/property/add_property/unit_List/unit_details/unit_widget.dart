import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/generated/assets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitDetailView {
  pageViewWidget() {
    final unitDetailsCntrl = Get.find<UnitDetailsController>();
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
    final unitCntrl = Get.find<UnitDetailsController>();
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
                SvgPicture.asset("assets/icons/i_icon.svg")
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
        if (unitCntrl.amenitiesList.isNotEmpty)
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
      ],
    );
  }

  Widget ratingWidget() {
    final unitCntrl = Get.find<UnitDetailsController>();
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
}
