import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/landlord_screens/navbar_management/floor_detail/floor_detail_widget.dart';

class FloorDetailView extends StatelessWidget {
  FloorDetailView({super.key});
  final floorDetailCntrl = Get.put(FloorDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back(result: floorDetailCntrl.isRefreshmentRequired.value);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        title: Text(floorDetailCntrl.propertyFloorName.value,
            style: CustomStyles.otpStyle050505W700S16),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(
            height: 1,
            color: lightBorderGrey,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.back(result: floorDetailCntrl.isRefreshmentRequired.value);
          return true;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
                child: commonText(title: 'units'.tr)),
            Obx(() {
              return Expanded(
                child: floorDetailCntrl.isUnitsStatsLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : floorDetailCntrl.items.isEmpty
                        ?  Center(
                            child: Text("no_units_found".tr),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: floorDetailCntrl.items.length,
                            itemBuilder: (context, index) {
                              return FloorDetailWidget().unitList(
                                  index: index,
                                  unitTitle: floorDetailCntrl.items[index]
                                      ['name'],
                                  price: floorDetailCntrl.items[index]
                                      ['unit_rent'],
                                  tenantName: floorDetailCntrl.items[index]
                                      ['tenant'],
                                  availablityTitle: floorDetailCntrl
                                      .items[index]['last_occupied_date'],
                                  icon: 'assets/icons/homeIcon.png',
                                  buildingIcon: floorDetailCntrl
                                          .items[index]['images'].isNotEmpty
                                      ? floorDetailCntrl.items[index]['images']
                                          [0]['image_url']
                                      : null,
                                  amenities: floorDetailCntrl.items[index]
                                      ['amenities'],
                                  unitId: floorDetailCntrl.items[index]['id'],
                                  isOccupied: floorDetailCntrl.items[index]
                                      ['is_occupied']);
                            },
                          ),
              );
            })
          ],
        ),
      ),
    );
  }
}
