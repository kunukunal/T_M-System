import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_widget.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import '../../../common/widgets.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchCntrl = Get.put(SearchCntroller());
  @override
  void initState() {
    super.initState();

    // Add listener to the ScrollController
    searchCntrl.scrollController.value.addListener(() {
      if (searchCntrl.scrollController.value.position.pixels ==
          searchCntrl.scrollController.value.position.maxScrollExtent) {
        // Trigger pagination when near the end
        // _loadMoreItems();
        print("daskldasd ${searchCntrl.nextPagination.value}");
        if (searchCntrl.nextPagination.value != "") {
          searchCntrl.searchUsingPagination(searchCntrl.nextPagination.value);
        }
      }
    });
  }

  @override
  void dispose() {
    searchCntrl.scrollController.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchWidget().appBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Divider(
          color: HexColor('#EBEBEB'),
          height: 1.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              customTextField(
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.all(10.r),
                  //   child: searchIcon,
                  // ),
                  hintStyle: CustomStyles.hintText,
                  hintText: 'unit'.tr,
                  controller: searchCntrl.searchCntrl.value,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (searchCntrl.searchCntrl.value.text.trim().isNotEmpty) {
                      searchCntrl.getUnitBySearch();
                    } else {
                      customSnackBar(Get.context!,
                          "Please enter the property name for search");
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (searchCntrl.searchCntrl.value.text
                          .trim()
                          .isNotEmpty) {
                        searchCntrl.getUnitBySearch();
                      } else {
                        customSnackBar(Get.context!,
                            "Please enter the property name for search");
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.r),
                      child: searchIcon,
                    ),
                  ),
                  isBorder: true,
                  isFilled: false),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchWidget().occUnoccContainer(
                          isCheckBoxShow: true,
                          icon: occupiedIcon,
                          checkBoxVal: searchCntrl.isOcupiedUnitShow.value,
                          onChange: (val) {
                            searchCntrl.isOcupiedUnitShow.value = val!;
                            searchCntrl.items.refresh();
                          },
                          titleUnit: 'occupied_units'.tr,
                          units: searchCntrl.occupiedUnits.value.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      SearchWidget().occUnoccContainer(
                          isCheckBoxShow: true,
                          checkBoxVal: searchCntrl.isUnOcupiedUnitShow.value,
                          onChange: (val) {
                            searchCntrl.isUnOcupiedUnitShow.value = val!;
                            searchCntrl.items.refresh();
                          },
                          icon: unOccupiedIcon,
                          titleUnit: 'unoccupied_units'.tr,
                          units: searchCntrl.availableUnits.value.toString()),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, bottom: 10.w),
          child: Text(
            "units".tr,
            style: TextStyle(
                fontSize: 16.sp - commonFontSize,
                fontWeight: FontWeight.w700,
                color: black),
          ),
        ),
        Obx(() {
          return Expanded(
              child: searchCntrl.unitDataLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchCntrl.items.isEmpty
                      ? const Center(
                          child: Text("No Units found"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: searchCntrl.scrollController.value,
                          itemCount: searchCntrl.items.length +
                              (searchCntrl.paginationLoading.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == searchCntrl.items.length) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Loading indicator
                            } else {
                              bool isOccupied =
                                  searchCntrl.items[index]['is_occupied'];

                              // If both `isOcupiedUnitShow` and `isUnOcupiedUnitShow` are true, show all items
                              if (searchCntrl.isOcupiedUnitShow.value &&
                                  searchCntrl.isUnOcupiedUnitShow.value) {
                                return SearchWidget().unitList(
                                  unitTitle: searchCntrl.items[index]['name'],
                                  price: searchCntrl.items[index]['unit_rent'],
                                  availablityTitle: searchCntrl.items[index]
                                      ['available_from'],
                                  lastOccoupiedDate: searchCntrl.items[index]
                                      ['last_occupied_date'],
                                  amenities: searchCntrl.items[index]
                                      ['amenities'],
                                  buildingid: searchCntrl.items[index]
                                      ['building_id'],
                                  floorid: searchCntrl.items[index]['floor_id'],
                                  tenant: searchCntrl.items[index]['tenant'],
                                  isrentnegotiable: searchCntrl.items[index]
                                      ['is_rent_negotiable'],
                                  propertyid: searchCntrl.items[index]
                                      ['property_id'],
                                  unitId: searchCntrl.items[index]['id'],
                                  buildingIcon: searchCntrl.items[index]
                                      ['image'],
                                  property: searchCntrl.items[index]
                                      ['property'],
                                  building: searchCntrl.items[index]
                                      ['building'],
                                  floor: searchCntrl.items[index]['floor'],
                                  isOccupied: isOccupied,
                                );
                              }

                              // Show items based on the filters
                              if ((searchCntrl.isOcupiedUnitShow.value &&
                                      isOccupied) ||
                                  (searchCntrl.isUnOcupiedUnitShow.value &&
                                      !isOccupied)) {
                                return SearchWidget().unitList(
                                  unitTitle: searchCntrl.items[index]['name'],
                                  price: searchCntrl.items[index]['unit_rent'],
                                  availablityTitle: searchCntrl.items[index]
                                      ['available_from'],
                                  lastOccoupiedDate: searchCntrl.items[index]
                                      ['last_occupied_date'],
                                  amenities: searchCntrl.items[index]
                                      ['amenities'],
                                  buildingid: searchCntrl.items[index]
                                      ['building_id'],
                                  floorid: searchCntrl.items[index]['floor_id'],
                                  isrentnegotiable: searchCntrl.items[index]
                                      ['is_rent_negotiable'],
                                  propertyid: searchCntrl.items[index]
                                      ['property_id'],
                                  unitId: searchCntrl.items[index]['id'],
                                  buildingIcon: searchCntrl.items[index]
                                      ['image'],
                                  property: searchCntrl.items[index]
                                      ['property'],
                                  building: searchCntrl.items[index]
                                      ['building'],
                                  floor: searchCntrl.items[index]['floor'],
                                  isOccupied: isOccupied,
                                );
                              }

                              // If no condition is met, return an empty SizedBox
                              return SizedBox();
                            }

                            // Get the value of isOccupied for the current item
                          },
                        ));
        })
      ]),
    );
  }
}
