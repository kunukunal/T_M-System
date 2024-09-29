import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/generated/assets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_details_controller.dart';

class UnitDetails extends StatelessWidget {
  UnitDetails({super.key});
  final unitCntrl = Get.put(UnitDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Unit Review", style: CustomStyles.otpStyle050505W700S16)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                        Text(
                            unitCntrl.reviewCategory[index]['rating']
                                .toString(),
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
                          leading: unitCntrl.reviewList[index]
                                      ['profile_image'] !=
                                  null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(unitCntrl
                                      .reviewList[index]['profile_image']),
                                )
                              : const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(Assets.iconsProfile),
                                ),
                          title: Text(
                            unitCntrl.reviewList[index]['tenant'],
                            style: CustomStyles.titleText.copyWith(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                          subtitle:
                              Text(unitCntrl.reviewList[index]['created_at']),
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
            )),
      ),
    );
  }
}
