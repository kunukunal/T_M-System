import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_widget.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import '../../../common/widgets.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final searchCntrl = Get.put(SearchCntroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchWidget().appBar(),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(

              children: [
                SizedBox(height: 10.h,),
                customTextField(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: searchIcon,
                    ),
                    hintStyle: CustomStyles.hintText,
                    hintText: 'Unit',
                    controller: searchCntrl.searchCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    isBorder: true,
                    isFilled: false),
             Padding(
               padding:  EdgeInsets.symmetric(vertical: 15.h),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                 SearchWidget().occUnoccContainer(
                     icon: occupiedIcon,
                     titleUnit: 'Occupied Units',
                     units: '300'),
                 SearchWidget().occUnoccContainer(
                     icon: unOccupiedIcon,
                     titleUnit: 'Unoccupied Units',
                     units: '200'),
               ],),
             ),

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 10.w,bottom: 10.w),

            child: Text(
              "Units",
              style: TextStyle(fontSize: 16.sp - commonFontSize,fontWeight: FontWeight.w700, color: black),
            ),
          ),
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
              itemCount:searchCntrl.items.value.length,
              itemBuilder: (context, index) {
                return SearchWidget().unitList(
                  unitTitle: searchCntrl.items.value[index]['unitTitle'] as String,
                  price: searchCntrl.items.value[index]['price'] as String,
                  availablityTitle: searchCntrl.items.value[index]['availablityTitle'] as String,
                  icon: searchCntrl.items.value[index]['icon'] as String,
                  buildingIcon: searchCntrl.items.value[index]['buildingIcon'] as String,
                  property: searchCntrl.items.value[index]['property'] as String,
                  building: searchCntrl.items.value[index]['building'] as String,
                  floor: searchCntrl.items.value[index]['floor'] as String,
                  isOccupied: searchCntrl.items.value[index]['isOccupied'] as bool
                );
              },

            ),
          )
        ]),
      ),
    );
  }
}
