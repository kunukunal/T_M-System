import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/add_tenant_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_list_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_list_widgets.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';

class TenantListScreen extends StatelessWidget {
  TenantListScreen({super.key});

  final tenantCntrl = Get.put(TenantListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: Text('Kirayedar Management',
            style: CustomStyles.otpStyle050505W700S16),
        actions: [
          searchIcon,
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tenantCntrl.goesForAddConatct.value = true;
          Get.to(() => AddTenantScreen(), arguments: [
            false,
            {},
            {'isEdit': false}
          ])!
              .then((value) {
                tenantCntrl.getKireyderList();
            // if (value == true) {
            //   tenantCntrl.getKireyderList();
            // }

            // if (tenantCntrl.goesForAddConatct.value && value == false) {
            //   tenantCntrl.goesForAddConatct.value = false;
            //   tenantCntrl.getKireyderList();
            // }
          });
        },
        backgroundColor: Colors.white,
        shape: CircleBorder(side: BorderSide(color: HexColor('#EBEBEB'))),
        child: addIcon,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await tenantCntrl.getKireyderList();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: HexColor('#EBEBEB'),
              height: 1.h,
            ),
            Obx(() {
              return Expanded(
                child: tenantCntrl.kireyderListLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : tenantCntrl.tenantList.isEmpty
                        ? SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100.h,
                                ),
                                emptyTenantImage,
                                Text(
                                  'Empty Tenant',
                                  style: CustomStyles.otpStyle050505,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return TenantListWidgets()
                                      .containerWidget(index);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.h,
                                  );
                                },
                                itemCount: tenantCntrl.tenantList.length),
                          ),
              );
            })
          ],
        ),
      ),
    );
  }
}
