import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_details_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_details_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_list_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TenantListWidgets {
  //List container widget
  containerWidget(index) {
    final tenantCntrl = Get.find<TenantListController>();
    return InkWell(
      onTap: () {
        tenantCntrl.onTenantTap(tenantCntrl.tenantList[index]['id']);
      },
      child: Container(
        height: 84.h,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'))),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: HexColor('#444444'),
                    shape: BoxShape.circle,
                    image: tenantCntrl.tenantList[index]['profile_image'] !=
                            null
                        ? DecorationImage(
                            image: NetworkImage(
                                tenantCntrl.tenantList[index]['profile_image']))
                        : DecorationImage(
                            image: profileIconWithWidget.image,
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
                    Text(
                      tenantCntrl.tenantList[index]['name'] ?? "",
                      style: CustomStyles.otpStyle050505
                          .copyWith(fontSize: 16.sp - commonFontSize),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        height: 40.h,
                        width: double.infinity,
                        child: Text(
                          tenantCntrl.tenantList[index]['address'] ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomStyles.desc606060
                              .copyWith(fontSize: 14.sp - commonFontSize),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //**********************************Tenant Widgets*****************************

  tenantDetailContainer() {
    final cntrl = Get.find<TenantDetailsController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                ClipRect(
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                        image: cntrl.profileImage.value == ""
                            ? DecorationImage(
                                image: profileIconWithWidget.image)
                            : DecorationImage(
                                image: NetworkImage(cntrl.profileImage.value))),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Text(
                  cntrl.name.value,
                  style: CustomStyles.otpStyle050505W700S16
                      .copyWith(fontWeight: FontWeight.w500),
                )),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                    onTap: () async {
                      if (cntrl.email.isNotEmpty) {
                        try {
                          final nativeUrl = Uri.parse("mailto:${cntrl.email}");
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
                      if (cntrl.phoneNumber.isNotEmpty) {
                        try {
                          final nativeUrl =
                              Uri.parse("tel:${cntrl.phoneNumber}");
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
                '${cntrl.phoneCode} ${cntrl.phoneNumber}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget('${'email_address'.tr}      :', '${cntrl.email}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget(
                '${'address'.tr}                :', '${cntrl.address}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget(
                '${'occupied_units'.tr}   :', '${cntrl.occupiedUnit}'),
          ],
        ),
      ),
    );
  }

  tenantRentContainer() {
    final cntrl = Get.find<TenantDetailsController>();

    double totalRent = cntrl.rentData['total_rent'] ?? 0.0; // Total rent amount
    double paidRent = cntrl.rentData['rent_paid'] ?? 0.0; // Amount of rent paid
    double progress = 0.0;

    if (totalRent > 0) {
      progress = paidRent / totalRent;
    }
    return Container(
      height: 115.h,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: HexColor('#EBEBEB')),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'rent'.tr,
                  style: CustomStyles.otpStyle050505W700S16,
                ),
                // Row(
                //   children: [
                //     Text(
                //       'month_to_month'.tr,
                //       style: CustomStyles.desc606060.copyWith(
                //           fontSize: 14.sp - commonFontSize,
                //           fontFamily: 'DM Sans'),
                //     ),
                //     SizedBox(
                //       width: 10.w,
                //     ),
                //     filterIcon
                //   ],
                // )
              ],
            ),
            SizedBox(height: 10.h),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: HexColor('#D9E3F4'),
              valueColor: AlwaysStoppedAnimation<Color>(HexColor('#679BF1')),
              minHeight: 5.h,
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rent Received',
                      style: CustomStyles.desc606060.copyWith(
                          fontSize: 14.sp - commonFontSize,
                          fontFamily: 'DM Sans'),
                    ),
                    Text(
                      '₹${cntrl.rentData['rent_paid']}',
                      style: CustomStyles.black16,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'due'.tr,
                      style: CustomStyles.desc606060.copyWith(
                          fontSize: 14.sp - commonFontSize,
                          fontFamily: 'DM Sans'),
                    ),
                    Text(
                      '₹${cntrl.rentData['rent_due']}',
                      style: CustomStyles.black16,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  tenantUnitContainer() {
    final cntrl = Get.find<TenantDetailsController>();

    return cntrl.tenantUnitList.isEmpty
        ? Center(
            child: Text("no_units_found".tr),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("jkhkhkhh ${cntrl.tenantUnitList[index]}");
                  Get.to(() => UnitDetails(),
                      arguments: [cntrl.tenantUnitList[index]['id']]);
                },
                child: Container(
                  // height: 208.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor('#EBEBEB')),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRect(
                              child: Container(
                                height: 90.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: cntrl.tenantUnitList[index]['image']
                                            .isEmpty
                                        ? DecorationImage(
                                            image: apartment1Image.image)
                                        : DecorationImage(
                                            image: NetworkImage(cntrl
                                                    .tenantUnitList[index]
                                                ['image'][0]['image_url']))),
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
                                        cntrl.tenantUnitList[index]['name'] ??
                                            "",
                                        style: CustomStyles.black14,
                                      )),
                                      Text(
                                        "₹${cntrl.tenantUnitList[index]['unit_rent']}"
                                            .toString(),
                                        style: CustomStyles.amountFA4343W700S12,
                                      )
                                    ],
                                  ),
                                  Text(
                                    cntrl.tenantUnitList[index]['unit_info'] ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: CustomStyles.blue679BF1w700s20
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter'),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        cntrl.tenantUnitList[index]
                                                ['address'] ??
                                            "",
                                        style:
                                            CustomStyles.address050505w400s12,
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Divider(
                          color: HexColor('#EBEBEB'),
                          height: 1,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'amenities'.tr,
                              style: CustomStyles.otpStyle050505.copyWith(
                                  fontSize: 14.sp - commonFontSize,
                                  fontFamily: 'DM Sans'),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            cntrl.tenantUnitList[index]['amenities'].isEmpty
                                ? Center(
                                    child: Text("no_amenties".tr),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        spacing: 10,
                                        direction: Axis.vertical,
                                        children: [
                                          ...List.generate(
                                            cntrl
                                                .tenantUnitList[index]
                                                    ['amenities']
                                                .length,
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
                                                  Text(cntrl.tenantUnitList[
                                                          index]['amenities']
                                                      [index]['name']),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Text(
                                                      "₹ ${cntrl.tenantUnitList[index]['amenities'][index]['price']}") // You can use unitCntrl.amenitiesList[index] to dynamically set the text
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
            itemCount: cntrl.tenantUnitList.length);
  }

  tenantPaymentHistoryContainer() {
    final cntrl = Get.find<TenantDetailsController>();

    return cntrl.paymentList.isEmpty
        ? Center(
            child: Text("no_payment_history_found".tr),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DateTime dateTime =
                  DateTime.parse(cntrl.paymentList[index]['created_at']);
              String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#EBEBEB')),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: HexColor('#BCD1F3'),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: Text(
                            formattedDate,
                            textAlign: TextAlign.center,
                            style: CustomStyles.black16.copyWith(
                              fontSize: 14.sp - commonFontSize,
                            ),
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
                            Text(
                              cntrl.paymentList[index]['unit'],
                              textAlign: TextAlign.center,
                              style: CustomStyles.black16.copyWith(
                                fontSize: 15.sp - commonFontSize,
                              ),
                            ),
                            Text(
                              cntrl.paymentList[index]['unit_info'] ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: CustomStyles.blue679BF1w700s20.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter'),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              cntrl.paymentList[index]['unit_address'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: CustomStyles.desc606060.copyWith(
                                  fontSize: 12.sp - commonFontSize,
                                  fontFamily: 'DM Sans'),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              cntrl.paymentList[index]['transaction_id'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: CustomStyles.desc606060.copyWith(
                                  fontSize: 12.sp - commonFontSize,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'DM Sans'),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "₹${cntrl.paymentList[index]['unit_rent']}",
                        style: CustomStyles.amountFA4343W500S15,
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
            itemCount: cntrl.paymentList.length);
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
