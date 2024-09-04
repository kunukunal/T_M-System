import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/add_tenant_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/tenant_documents.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_details_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_list_widgets.dart';
import 'package:tanent_management/landlord_screens/profile/documents/document_view.dart';
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
            Get.back(result: tenantDetailsCntrl.isRefreshMentRequired.value);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: Text('kirayedar_details'.tr,
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
                    ])!
                    .then((value) {
                  if (value) {
                    tenantDetailsCntrl.isRefreshMentRequired.value = true;
                    tenantDetailsCntrl.getKireyderDetails();
                  }
                  print("dalkdlas ${value}");
                });
              },
              child: addIcon),
          SizedBox(
            width: 15.w,
          ),
          InkWell(
              onTap: () {
                print("rajat");
                Get.to(
                  () => AddTenantScreen(),
                  arguments: [
                    true,
                    {},
                    {
                      'isEdit': true,
                      'name': tenantDetailsCntrl.name.value,
                      'phone_code': tenantDetailsCntrl.phoneCode.value,
                      'phone_number': tenantDetailsCntrl.phoneNumber.value,
                      'email': tenantDetailsCntrl.email.value,
                      'address': tenantDetailsCntrl.address.value,
                      'landmark': "",
                      'id': tenantDetailsCntrl.kireyderId.value,
                      'pincode': tenantDetailsCntrl.pincode.value,
                      'city': tenantDetailsCntrl.city.value,
                      'state': tenantDetailsCntrl.state.value,
                      'profile_pic': tenantDetailsCntrl.profileImage.value
                    }
                  ],
                )!
                    .then((value) {
                  if (value) {
                    tenantDetailsCntrl.isRefreshMentRequired.value = true;
                    tenantDetailsCntrl.getKireyderDetails();
                  }
                });
              },
              child: editIcon),
          SizedBox(
            width: 15.w,
          ),
          InkWell(
              onTap: () {
                if (tenantDetailsCntrl.tenantDoc.isEmpty) {
                  Get.to(() => TenantDocScreen(), arguments: [
                    tenantDetailsCntrl.kireyderId.value,
                    false,
                    {'isEdit': false, 'isConsent': true},
                    true
                  ])!
                      .then((value) {
                    if (value == true) {
                      tenantDetailsCntrl.getKireyderDetails();
                    }
                  });
                } else {
                  Get.to(
                      () => DocumentScreen(
                            isFromTenant: true,
                          ),
                      arguments: [true, tenantDetailsCntrl.kireyderId.value,false]);
                }
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
                            'units'.tr,
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
                            'payment_history'.tr,
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
      ),
    );
  }
}
