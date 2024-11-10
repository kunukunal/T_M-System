import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/tenant_screens/explore/explore_controller.dart';
import 'package:tanent_management/tenant_screens/explore/search_modal.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_view.dart';

class ExploreWidget {
  exploreSearch({String? icon, String? titleUnit, String? units}) {
    final exploreCntrl = Get.find<ExploreController>();
    // Timer? _debounce;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: lightBorderGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 7.w,
              right: 7.w,
              top: 10.h,
            ),
            child: TextFormField(
              controller: exploreCntrl.serachPropertyController.value,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    "assets/icons/location.png",
                  ),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (exploreCntrl.serachPropertyController.value.text
                          .trim()
                          .isNotEmpty) {
                        print(
                            "dskfldslfkldskflsdflk ${exploreCntrl.serachPropertyController.value.text.trim()}");
                        exploreCntrl.getPropertyBySearchLocation(exploreCntrl
                            .serachPropertyController.value.text
                            .trim());
                      }
                    },
                    icon: const Icon(Icons.search)),
                hintText: "enter_location".tr,
                prefixIconConstraints: BoxConstraints.loose(Size(35.w, 35.h)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightBorderGrey),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightBorderGrey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightBorderGrey),
                ),
              ),
              onChanged: (value) {
                // if (_debounce?.isActive ?? false) _debounce?.cancel();
                // _debounce = Timer(const Duration(milliseconds: 100), () {
                //   if (value.isNotEmpty) {
                //     exploreCntrl.getPropertyBySearchLocation(value);
                //   }
                // });
              },
              onFieldSubmitted: (value) {
                if (exploreCntrl.serachPropertyController.value.text
                    .trim()
                    .isNotEmpty) {
                  exploreCntrl.getPropertyBySearchLocation(
                      exploreCntrl.serachPropertyController.value.text.trim());
                }
              },
            ),
          ),
          Obx(() {
            return exploreCntrl.exploreSearch.isNotEmpty &&
                    exploreCntrl.exploreSearch[0].id != -1
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: exloreDropDown(
                          selectedItem:
                              exploreCntrl.exploreSearchItemSelected.value,
                          color: whiteColor,
                          items: exploreCntrl.exploreSearch,
                          onChange: (Property item) {
                            exploreCntrl.exploreSearchItemSelected.value = item;
                            exploreCntrl.onTapSearchProperty();
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: 10.h, horizontal: 7.w),
                      //   child: exploreCntrl.getUnitByPropertySearchLoading.value
                      //       ? const Center(child: CircularProgressIndicator())
                      //       : customBorderButton("get_units".tr, () {
                      //           exploreCntrl.onTapSearchProperty();
                      //         },
                      //           fontweight: FontWeight.w500,
                      //           verticalPadding: 5.h,
                      //           horizontalPadding: 2.w,
                      //           btnHeight: 40.h,
                      //           color: HexColor('#679BF1'),
                      //           textColor: HexColor('#FFFFFF'),
                      //           borderColor: Colors.transparent),
                      // )
                    ],
                  )
                : SizedBox();
          })
        ],
      ),
    );
  }

  exloreDropDown(
      {Property? selectedItem,
      required List<Property> items,
      bool isReadOnly = false,
      required Function(Property) onChange,
      Color? color,
      double? width}) {
    return Row(
      children: [
        addPropertyIcon,
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Container(
            height: 44.h,
            width: width ?? Get.width,
            decoration: BoxDecoration(
                color: color ?? whiteColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: HexColor('#EBEBEB'), width: 2)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DropdownButton<Property>(
                isExpanded: true,
                icon: dropDownArrowIcon,
                underline: Container(),
                value: items.contains(selectedItem) ? selectedItem : null,
                hint: Text(
                  'select_property'.tr,
                  style: CustomStyles.hintText,
                ),
                items: items.map((Property item) {
                  return DropdownMenuItem<Property>(
                    value: item,
                    child: Text(
                      item.title,
                      style: CustomStyles.hintText,
                    ),
                  );
                }).toList(),
                onChanged: (Property? item) {
                  if (item != null) {
                    onChange(item);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  searchResult() {
    final exploreCntrl = Get.find<ExploreController>();

    return Obx(() {
      return exploreCntrl.getUnitResult.isEmpty
          ? Center(
              child: Text("no_units_found".tr),
            )
          : ListView.separated(
              shrinkWrap: true,
              controller: exploreCntrl.scrollController.value,
              itemCount: exploreCntrl.getUnitResult.length +
                  (exploreCntrl.paginationLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == exploreCntrl.getUnitResult.length) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else {
                  return InkWell(
                    onTap: () {
                      Get.to(() => UnitDetailView(), arguments: [
                        exploreCntrl.getUnitResult[index]['id'],
                        false
                      ]);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#EBEBEB')),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRect(
                                  child: Container(
                                    height: 65.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: exploreCntrl.getUnitResult[index]
                                                    ['image'] !=
                                                null
                                            ? DecorationImage(
                                                image: NetworkImage(exploreCntrl
                                                        .getUnitResult[index]
                                                    ['image']),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/apartment1_image.png"))),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            exploreCntrl.getUnitResult[index]
                                                    ['name'] ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomStyles.black14,
                                          )),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${exploreCntrl.getUnitResult[index]['unit_rent'] ?? ""}",
                                                style: CustomStyles
                                                    .amountFA4343W700S12
                                                    .copyWith(
                                                        color: lightBlue,
                                                        fontSize: 15.0 -
                                                            commonFontSize),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  exploreCntrl.addFavouriteUnit(
                                                      exploreCntrl
                                                              .getUnitResult[
                                                          index]['id'],
                                                      index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: exploreCntrl
                                                              .getUnitResult[
                                                          index]['favorite']
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(Icons
                                                          .favorite_border_outlined),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Text(
                                        exploreCntrl.getUnitResult[index]
                                                ['unit_info'] ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: CustomStyles.blue679BF1w700s20
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                fontFamily: 'Inter'),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        exploreCntrl.getUnitResult[index]
                                                ['address'] ??
                                            "",
                                        style:
                                            CustomStyles.address050505w400s12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                const Flexible(
                                                    child: Icon(Icons
                                                        .bedroom_parent_outlined)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    exploreCntrl.getUnitResult[
                                                                index]
                                                            ['unit_type'] ??
                                                        "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Flexible(
                                          //   child: Row(
                                          //     children: [
                                          //       Flexible(
                                          //           child: Icon(
                                          //               Icons.bathroom_outlined)),
                                          //       Flexible(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "4 Bathrooms",
                                          //           overflow:
                                          //               TextOverflow.ellipsis,
                                          //           maxLines: 1,
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                    child: SvgPicture.asset(
                                                  "assets/icons/squareftratio.svg",
                                                  height: 20,
                                                )),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    "${exploreCntrl.getUnitResult[index]['area_size'] ?? ""} ${'sqft'.tr}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            );
    });
  }
}
