import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_details_controller.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_widgets.dart';
import 'package:tanent_management/screens/profile/documents/document_view.dart';
import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';
import '../../management/management_view.dart';

class TenantDetailScreen extends StatelessWidget {
  TenantDetailScreen({super.key});
  final tenantDetailsCntrl = Get.put(TenantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: Text('Kirayedar Details',
            style: CustomStyles.otpStyle050505W700S16),
        actions: [
          InkWell(
              onTap: () {
                Get.to(
                    () => ManagementScreen(
                          isFromDashboard: true,
                        ),
                    arguments: [
                      true,
                      {
                        'name': tenantDetailsCntrl.name.value,
                        'id': tenantDetailsCntrl.kireyderId.value,
                        'phone_code': tenantDetailsCntrl.phoneCode.value,
                        'phone_number': tenantDetailsCntrl.phoneNumber.value,
                      }
                    ]);
              },
              child: addIcon),
          SizedBox(
            width: 15.w,
          ),
          InkWell(onTap: () {}, child: notifIcon),
          SizedBox(
            width: 15.w,
          ),
          InkWell(
              onTap: () {
                Get.to(
                    () => DocumentScreen(
                          isFromTenant: true,
                        ),
                    arguments: [true, tenantDetailsCntrl.kireyderId.value]);
              },
              child: documentIcon),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: Obx(() {
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
                  TenantListWidgets().tenantDetailContainer(),
                  Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        TenantListWidgets().tenantRentContainer(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Units',
                          style: CustomStyles.otpStyle050505W700S16,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TenantListWidgets().tenantUnitContainer(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Payment History',
                          style: CustomStyles.otpStyle050505W700S16,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TenantListWidgets().tenantPaymentHistoryContainer(),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}
