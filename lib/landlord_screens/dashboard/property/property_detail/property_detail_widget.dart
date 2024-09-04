import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/generated/assets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_detail/property_detail_controller.dart';

class PropertyDetailViewWidget {
  pageViewWidget() {
    final walkCntrl = Get.find<PropertyDetailViewController>();
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
                  controller: walkCntrl.pageController.value,
                  children: [
                    profileImage,
                    profileImage,
                    profileImage,
                    profileImage,
                  ],
                ),
                Positioned(
                  bottom: 10.h,
                  right: Get.width / 2.8,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: SmoothPageIndicator(
                      controller: walkCntrl.pageController.value,
                      count: 4,
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
    final walkCntrl = Get.find<PropertyDetailViewController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "John Apartments",
                style: CustomStyles.titleText
                    .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
              ),
              Row(
                children: [
                  const Text("₹ 4,509.00"),
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
              const Expanded(
                  child:
                      Text("2118 Thornridge Cir. Syracause, Connecticut 35624"))
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
              const Expanded(child: Text("Available From 10 April 2024"))
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "amenities".tr,
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          SizedBox(
            height: 5.h,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 6, // Ensures each item is square
            ),
            itemCount: walkCntrl.amenitiesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                  Text(walkCntrl.amenitiesList[
                      index]) // You can use walkCntrl.amenitiesList[index] to dynamically set the text
                ],
              );
            },
          ),
          const Divider(),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(Assets.iconsProfile),
              ),
              title: Text(
                "John Wick",
                style: CustomStyles.titleText
                    .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
              ),
              subtitle: 
               Text("landlord".tr),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Column(
            children: [
              Image.asset("assets/icons/map.png"),
              const Text(
                "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.",
                style: TextStyle(fontSize: 17),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget ratingWidget() {
    final walkCntrl = Get.find<PropertyDetailViewController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/star.svg"),
              SizedBox(
                width: 5.w,
              ),
              const Text(
                "4.4 (100 Reviews)",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            padding: EdgeInsets.only(right: 10.w),
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
            itemCount: walkCntrl.reviewCategory.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    walkCntrl.reviewCategory[index],
                    style: const TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Expanded(child: Divider()),
                  SizedBox(
                    width: 5.w,
                  ),
                  const Text("4.9", style: TextStyle(fontSize: 15))
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
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(Assets.iconsProfile),
                    ),
                    title: Text(
                      "John Wick",
                      style: CustomStyles.titleText.copyWith(
                          fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                    ),
                    subtitle: const Text("March 2024"),
                  ),
                  const Text(
                    "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
        ],
      ),
    );
  }
}
