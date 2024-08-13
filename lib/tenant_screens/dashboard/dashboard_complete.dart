import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_widgets.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_view.dart';
import '../../landlord_screens/dashboard/search/search_widget.dart';

class CompleteDashboard extends StatelessWidget {
  CompleteDashboard({super.key});
  final dashCntrl = Get.find<DashBoardTenantController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchWidget().occUnoccContainer(
                      icon: occupiedIcon,
                      titleUnit: 'Rent Due',
                      units: "₹${dashCntrl.rentData['rent_due']}"),
                  SizedBox(
                    width: 5.w,
                  ),
                  SearchWidget().occUnoccContainer(
                      icon: unOccupiedIcon,
                      titleUnit: 'Next Due Date',
                      units: dashCntrl.rentData['next_due_date'].toString()),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Units",
                style: CustomStyles.titleText
                    .copyWith(fontWeight: FontWeight.w700, fontFamily: 'Inter'),
              ),
              SizedBox(
                height: 10.h,
              ),
              unitList(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment History",
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w700, fontFamily: 'Inter'),
                  ),
                  Text(
                    "See All",
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        color: grey),
                  ),
                ],
              ),
              DashBoardTenantWidgets().paymentHistory()
            ],
          );
        }),
      ),
    );
  }
}

unitList() {
  final dashCntrl = Get.find<DashBoardTenantController>();

  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: dashCntrl.unitList.length,
    itemBuilder: (context, index) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor('#EBEBEB')),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => UnitDetailView(), arguments: [
                    dashCntrl.unitList[index]['id'],
                    true,
                  ]);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRect(
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: dashCntrl.unitList[index]['image'] != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        dashCntrl.unitList[index]['image']),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: profileIconWithWidget.image)),
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
                            children: [
                              Expanded(
                                  child: Text(
                                dashCntrl.unitList[index]['name'] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomStyles.black14,
                              )),
                              Text(
                                "₹${dashCntrl.unitList[index]['rent'] ?? ""}",
                                style: CustomStyles.amountFA4343W700S12
                                    .copyWith(
                                        color: Colors.red,
                                        fontSize: 15.0 - commonFontSize),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 25.r,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                  child: Text(
                                dashCntrl.unitList[index]['address'] ?? "",
                                style: CustomStyles.address050505w400s12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: lightBorderGrey,
                // height: 1.h,
              ),
              customBorderWithIconButton(
                "Pay Your Rent",
                () {
                  dashCntrl.onTapPayRent(dashCntrl.unitList[index]);
                },
                verticalPadding: 5.h,
                horizontalPadding: 2.w,
                btnHeight: 35.h,
                borderColor: HexColor('#679BF1'),
                textColor: HexColor('#679BF1'),
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 10.h,
      );
    },
  );
}
