import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
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
        title: Text('kirayedar_management'.tr,
            style: CustomStyles.otpStyle050505W700S16),
        // actions: [
        //   searchIcon,
        //   SizedBox(
        //     width: 10.w,
        //   )
        // ],
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
            // Divider(
            //   color: HexColor('#EBEBEB'),
            //   height: 1.h,
            // ),

            Obx(() {
              return Expanded(
                child: tenantCntrl.kireyderListLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : tenantCntrl.tenantList.isEmpty
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100.h,
                                ),
                                emptyTenantImage,
                                Text(
                                  'empty_tenant'.tr,
                                  style: CustomStyles.otpStyle050505,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: Column(
                              children: [
                                customTextField(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: searchIcon,
                                    ),
                                    hintStyle: CustomStyles.hintText,
                                    hintText: 'search_kirayedar'.tr,
                                    controller: tenantCntrl
                                        .kiryedarSearchController.value,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.emailAddress,
                                    onChange: (value) {
                                      tenantCntrl.tenantList.refresh();
                                    },
                                    isBorder: true,
                                    isFilled: false),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        String tenantName =
                                            (tenantCntrl.tenantList[index]
                                                        ['name'] ??
                                                    "")
                                                .toString()
                                                .trim();
                                        String searchQuery = tenantCntrl
                                            .kiryedarSearchController.value.text
                                            .trim()
                                            .toLowerCase();

                                        if (tenantName
                                            .toLowerCase()
                                            .contains(searchQuery)) {
                                          return TenantListWidgets()
                                              .containerWidget(index);
                                        }
                                        return const SizedBox();
                                      },
                                      separatorBuilder: (context, index) {
                                        String tenantName =
                                            (tenantCntrl.tenantList[index]
                                                        ['name'] ??
                                                    "")
                                                .toString()
                                                .trim();
                                        String searchQuery = tenantCntrl
                                            .kiryedarSearchController.value.text
                                            .trim()
                                            .toLowerCase();

                                        if (tenantName
                                            .toLowerCase()
                                            .contains(searchQuery)) {
                                          return SizedBox(
                                            height: 10.h,
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                      itemCount: tenantCntrl.tenantList.length),
                                ),
                              ],
                            ),
                          ),
              );
            })
          ],
        ),
      ),
    );
  }
}
