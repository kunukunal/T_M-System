import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/navbar_management/floor_detail/unit_history.dart';
import 'package:tanent_management/landlord_screens/notification/ad_as_tenant/tenant_controller.dart';
import 'package:tanent_management/landlord_screens/notification/ad_as_tenant/tenant_widget.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';

class AdasTenatDetailsScreen extends StatelessWidget {
  AdasTenatDetailsScreen({super.key});
  final tenantDetailsCntrl = Get.put(AdasTenatDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back(result: tenantDetailsCntrl.isRefreshMentRequired.value);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        title: Text('kirayedar_details'.tr,
            style: CustomStyles.otpStyle050505W700S16),
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => UnitHistory(),
                    arguments: [tenantDetailsCntrl.unitId.value]);
              },
              child: documentIcon),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.back(result: tenantDetailsCntrl.isRefreshMentRequired.value);
          return true;
        },
        child: Obx(() {
          return tenantDetailsCntrl.kireyderDetailsLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Divider(
                      color: HexColor('#EBEBEB'),
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TenantListDetailsScreenWidgets().tenantDetailContainer(),
                    Divider(
                      color: HexColor('#EBEBEB'),
                      height: 1.h,
                    ),
                    Obx(() {
                      return tenantDetailsCntrl.isRequestLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: tenantDetailsCntrl
                                          .isTenantAlreadyAdded.value
                                      ? 5
                                      : 0),
                              child: tenantDetailsCntrl
                                          .notificationTypeId.value ==
                                      3
                                  ? tenantDetailsCntrl
                                          .isTenantAlreadyAdded.value
                                      ? Center(
                                          child: Text(
                                            "tenant_already_added".tr,
                                            style: TextStyle(
                                                color: green,
                                                fontSize: commonFontSize + 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: customBorderButton(
                                                  'reject'.tr, () {
                                                tenantDetailsCntrl
                                                    .addRejectTenant(
                                                  isFromAccept: false,
                                                  notificationId:
                                                      tenantDetailsCntrl
                                                          .notificationId.value,
                                                  requestId: tenantDetailsCntrl
                                                      .processRequestId.value,
                                                );
                                              },
                                                  verticalPadding: 12.h,
                                                  horizontalPadding: 2.w,
                                                  btnHeight: 30.h,
                                                  borderColor:
                                                      HexColor('#679BF1'),
                                                  textColor:
                                                      HexColor('#679BF1')),
                                            ),
                                            Expanded(
                                              child: customBorderButton(
                                                'add_as_tenant'.tr,
                                                () {
                                                  tenantDetailsCntrl
                                                      .addRejectTenant(
                                                          tenantId:
                                                              tenantDetailsCntrl
                                                                  .tenantId
                                                                  .value);
                                                },
                                                verticalPadding: 12.h,
                                                horizontalPadding: 2.w,
                                                btnHeight: 30.h,
                                                color: HexColor('#679BF1'),
                                                borderColor:
                                                    HexColor('#679BF1'),
                                                textColor: HexColor('#FFFFFF'),
                                              ),
                                            )
                                          ],
                                        )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "exit_unit_request".tr,
                                          style: CustomStyles
                                              .otpStyle050505W700S16,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: customBorderButton(
                                                'reject_request'.tr,
                                                () {
                                                  tenantDetailsCntrl
                                                      .rejectExitRequestUnitApi(
                                                    tenantDetailsCntrl
                                                        .unitId.value,
                                                  );
                                                },
                                                verticalPadding: 12.h,
                                                horizontalPadding: 2.w,
                                                btnHeight: 30.h,
                                                color: red,
                                                borderColor: red,
                                                textColor: HexColor('#FFFFFF'),
                                              ),
                                            ),
                                            Expanded(
                                              child: customBorderButton(
                                                'accept_request'.tr,
                                                () {
                                                  tenantDetailsCntrl
                                                      .removeTenant(
                                                          tenantDetailsCntrl
                                                              .unitId.value,
                                                          tenantDetailsCntrl
                                                              .notificationId
                                                              .value);
                                                },
                                                verticalPadding: 12.h,
                                                horizontalPadding: 2.w,
                                                btnHeight: 30.h,
                                                color: HexColor('#679BF1'),
                                                borderColor:
                                                    HexColor('#679BF1'),
                                                textColor: HexColor('#FFFFFF'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'units'.tr,
                            style: CustomStyles.otpStyle050505W700S16,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TenantListDetailsScreenWidgets()
                              .tenantUnitContainer(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'documents'.tr,
                            style: CustomStyles.otpStyle050505W700S16,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TenantListDetailsScreenWidgets().documentList(),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
