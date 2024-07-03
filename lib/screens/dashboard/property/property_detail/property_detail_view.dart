import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/property_detail/property_detail_controller.dart';
import 'package:tanent_management/screens/dashboard/property/property_detail/property_detail_widget.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_widget.dart';

import '../../../../common/constants.dart';

class PropertyDetailView extends StatelessWidget {
   PropertyDetailView({super.key});
  final propertyDetailCntrl =Get.put(PropertyDetailViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Details'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Properties',
                style: TextStyle(fontSize: 16.sp, color: grey),
              ),
              bigDropDown(selectedItem: propertyDetailCntrl.selectedProperty.value,color:whiteColor , items: propertyDetailCntrl.propertyList.value, onChange: (item){
                propertyDetailCntrl.selectedProperty.value=item;
              }),
              PropertyDetailViewWidget().pageViewWidget()
            ],
          ),
        ));
  }
}
