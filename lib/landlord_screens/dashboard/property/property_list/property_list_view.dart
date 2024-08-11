import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_list/property_list_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_list/property_list_widgets.dart';

class PropertyListView extends StatelessWidget {
  PropertyListView({super.key});
  final propertyCntrl = Get.put(PropertyListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PropertyWidget().appBar(),
      floatingActionButton: Obx(() {
        return propertyCntrl.propertyList.isEmpty
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  // expenseCntrl.onAddTap();
                  propertyCntrl.onAddTap();
                },
                backgroundColor: Colors.white,
                shape:
                    CircleBorder(side: BorderSide(color: HexColor('#EBEBEB'))),
                child: addIcon,
              );
      }),
      body: Column(
        children: [
          Divider(
            color: lightBorderGrey,
            height: 1.h,
          ),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: propertyCntrl.isPropertyDataListLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : propertyCntrl.propertyList.isEmpty
                        ? Center(
                            child: Image.asset(
                                "assets/images/available_occupied_image.png"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: propertyCntrl.propertyList.length,
                            itemBuilder: (context, index) {
                              return PropertyWidget().unitList(
                                propertyIndex: index,
                                id: propertyCntrl.propertyList[index]['id'],
                                propertyTitle: propertyCntrl.propertyList[index]
                                    ['title'],
                                location: propertyCntrl.propertyList[index]
                                    ['address'],
                                // icon:  propertyCntrl.propertyList[index]['icon'] as String,
                                buildingIcon: propertyCntrl.propertyList[index]
                                    ['images'],
                                // isFeature:  propertyCntrl.propertyList[index]['isFeatured'] as bool
                              );
                            }),
              );
            }),
          )
        ],
      ),
    );
  }
}
