import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/management/managment_modal.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import '../../../common/widgets.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';
import '../../profile/edit_profile/edit_profile_widget.dart';
import 'management_controller.dart';
import 'management_widgets.dart';

class ManagementScreen extends StatelessWidget {
  final bool isFromDashboard;
  ManagementScreen({required this.isFromDashboard, super.key});

  final manageCntrl = Get.put(ManagementController());
  final authCntrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: backArrowImage,
          ),
        ),
        title: Text('Management', style: CustomStyles.otpStyle050505W700S16),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isFromDashboard
                      ? const SizedBox()
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PersonlInfoWidget.commomText('Tenant mobile number',
                                      isMandatory: true),
                                  customTextField(
                                      controller: manageCntrl.mobileCntrl.value,
                                      maxLength: 10,

                                      // width: 200.w,
                                      isForCountryCode: true,
                                      readOnly: manageCntrl.checkTanant.value,
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp - commonFontSize,
                                        color: HexColor('#6D6E6F'),
                                      ),
                                      autofocus: true,
                                      hintText: 'Enter Mobile No.',
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      isBorder: true,
                                      isFilled: false),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  manageCntrl.checkTanant.value
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                
                                                  backgroundColor:Color.fromARGB(255, 33, 194, 243),
                                                  shape:
                                                       RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12.r)
                                                      )),
                                              onPressed: manageCntrl
                                                      .tenantCheckLoading.value
                                                  ? null
                                                  : () {
                                                      manageCntrl
                                                          .verifyStatus();
                                                    },
                                              child: manageCntrl
                                                      .tenantCheckLoading.value
                                                  ? const CircularProgressIndicator()
                                                  : const Text(
                                                      "Check Tenant",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 5.h,
                  ),
                  manageCntrl.checkTanant.value == true &&
                          isFromDashboard == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PersonlInfoWidget.commomText('Tenant Name'),
                            customTextField(
                                controller: manageCntrl.nameCntrl.value,
                                maxLength: 10,
                                // width: 200.w,

                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp - commonFontSize,
                                  color: HexColor('#6D6E6F'),
                                ),
                                hintText: 'Enter Name',
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                isBorder: true,
                                isFilled: false),
                            // bigDropDown(
                            //     selectedItem:
                            //         manageCntrl.selectedTenantName.value,
                            //     items: manageCntrl.tenantList.value,
                            //     onChange: (item) {
                            //       manageCntrl.selectedTenantName.value = item;
                            //     }),
                            SizedBox(
                              height: 5.h,
                            ),
                            PersonlInfoWidget.commomText('Property'),
                            bigDropDown(
                                selectedItem:
                                    manageCntrl.selectedProjectName.value,
                                items: manageCntrl.projectsList,
                                isReadOnly: !isFromDashboard,
                                onChange: (item) {
                                  manageCntrl.selectedProjectName.value = item;
                                }),
                            SizedBox(
                              height: 5.h,
                            ),
                            PersonlInfoWidget.commomText('Building'),
                            bigDropDown(
                                selectedItem:
                                    manageCntrl.selectedTowerName.value,
                                isReadOnly: !isFromDashboard,
                                items: manageCntrl.towerList,
                                onChange: (item) {
                                  manageCntrl.selectedTowerName.value = item;
                                }),
                            SizedBox(
                              height: 5.h,
                            ),
                            PersonlInfoWidget.commomText('Floor'),
                            bigDropDown(
                                selectedItem:
                                    manageCntrl.selectedFloorName.value,
                                items: manageCntrl.floorList,
                                isReadOnly: !isFromDashboard,
                                onChange: (item) {
                                  manageCntrl.selectedFloorName.value = item;
                                }),
                            SizedBox(
                              height: 5.h,
                            ),
                            PersonlInfoWidget.commomText('Unit'),
                            bigDropDown(
                                selectedItem:
                                    manageCntrl.selectedUnitName.value,
                                isReadOnly: !isFromDashboard,
                                items: manageCntrl.unitList,
                                onChange: (item) {
                                  manageCntrl.selectedUnitName.value = item;
                                }),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditProfileWidget.commomText('Rent (Rs)',
                                        isMandatory: true),
                                    customTextField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            manageCntrl.amountCntrl.value,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        readOnly:
                                            manageCntrl.isRentNegiosate.value,
                                        width: Get.width / 2.3,
                                        hintText: 'Type Here...',
                                        isBorder: true,
                                        isFilled: false),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditProfileWidget.commomText('Rent Type',
                                        isMandatory: true),
                                    bigDropDown(
                                        width: 160.5.w,
                                        selectedItem:
                                            manageCntrl.selectedRentType.value,
                                        items: manageCntrl.rentTypeList,
                                        onChange: (value) {
                                          manageCntrl.selectedRentType.value =
                                              value;
                                        })
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditProfileWidget.commomText('Form (Rent)'),
                                    ManagementWidgets().datePickerContainer(
                                        manageCntrl.rentFrom.value == null
                                            ? 'Select'
                                            : '${manageCntrl.rentFrom.value!.day}-${manageCntrl.rentFrom.value!.month}-${manageCntrl.rentFrom.value!.year}',
                                        width: 158.w, onTap: () {
                                      manageCntrl.selectDateFrom(Get.context!);
                                    }),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EditProfileWidget.commomText('To (Rent)'),
                                    ManagementWidgets().datePickerContainer(
                                        manageCntrl.rentTo.value == null
                                            ? 'Select'
                                            : '${manageCntrl.rentTo.value!.day}-${manageCntrl.rentTo.value!.month}-${manageCntrl.rentTo.value!.year}',
                                        width: 158.w, onTap: () {
                                      manageCntrl.selectDateTo(Get.context!);
                                    }),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            PersonlInfoWidget.commomText('Remarks'),
                            customTextField(
                                controller: manageCntrl.remarkCntrl.value,
                                focusNode: manageCntrl.remarkFocus.value,
                                hintText: 'Type Here...',
                                isBorder: true,
                                color: HexColor('#FFFFFF'),
                                isFilled: false),
                            SizedBox(
                              height: 5.h,
                            ),
                            if (manageCntrl.amenitiesList.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PersonlInfoWidget.commomText(
                                    'Amenities',
                                  ),
                                  Divider(
                                    color: HexColor('#EBEBEB'),
                                    height: 1.h,
                                  ),
                                  ManagementWidgets().amenitiesList(),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),

                            Obx(() => manageCntrl.addTenantLoading.value == true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : customButton(
                                    onPressed: () {
                                      manageCntrl.onSubmitTap();
                                    },
                                    text: 'Submit',
                                    height: 45.h,
                                    width: Get.width))
                          ],
                        )
                      : isFromDashboard == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PersonlInfoWidget.commomText('Tenant Name'),
                                customTextField(
                                  controller: manageCntrl.nameCntrl.value,
                                  maxLength: 10,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp - commonFontSize,
                                    color: HexColor('#6D6E6F'),
                                  ),
                                  hintText: 'Enter Name',
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  isBorder: true,
                                  isFilled: false,
                                ),
                                SizedBox(height: 5.h),
                                PersonlInfoWidget.commomText('Property'),
                                Obx(() => buildDropdown<Property>(
                                      manageCntrl.selectedProperty.value,
                                      manageCntrl.projectsListData,
                                      'Select Property',
                                      (value) =>
                                          manageCntrl.onProjectSelected(value),
                                    )),
                                SizedBox(height: 5.h),
                                PersonlInfoWidget.commomText('Building'),
                                Obx(() => buildDropdown<Building>(
                                      manageCntrl.selectedBuilding.value,
                                      manageCntrl.selectedProperty.value
                                              ?.buildings ??
                                          [],
                                      'Select Building',
                                      (value) =>
                                          manageCntrl.onBuildingSelected(value),
                                    )),
                                SizedBox(height: 5.h),
                                PersonlInfoWidget.commomText('Floor'),
                                Obx(() => buildDropdown<Floor>(
                                      manageCntrl.selectedFloor.value,
                                      manageCntrl.floorsList,
                                      'Select Floor',
                                      (value) =>
                                          manageCntrl.onFloorSelected(value),
                                    )),
                                SizedBox(height: 5.h),
                                PersonlInfoWidget.commomText('Unit'),
                                Obx(() => buildDropdown<Unit>(
                                      manageCntrl.selectedUnit.value,
                                      manageCntrl.unitsList,
                                      'Select Unit',
                                      (value) =>
                                          manageCntrl.onUnitSelected(value),
                                    )),
                                SizedBox(height: 5.h),

                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EditProfileWidget.commomText(
                                            'Rent (Rs)',
                                            isMandatory: true),
                                        customTextField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                manageCntrl.amountCntrl.value,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            readOnly: manageCntrl
                                                .isRentNegiosate.value,
                                            width: Get.width / 2.3,
                                            hintText: 'Type Here...',
                                            isBorder: true,
                                            isFilled: false),
                                      ],
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EditProfileWidget.commomText(
                                            'Rent Type',
                                            isMandatory: true),
                                        bigDropDown(
                                            width: 160.5.w,
                                            selectedItem: manageCntrl
                                                .selectedRentType.value,
                                            items: manageCntrl.rentTypeList,
                                            onChange: (value) {
                                              manageCntrl.selectedRentType
                                                  .value = value;
                                            })
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EditProfileWidget.commomText(
                                            'Form (Rent)'),
                                        ManagementWidgets().datePickerContainer(
                                            manageCntrl.rentFrom.value == null
                                                ? 'Select'
                                                : '${manageCntrl.rentFrom.value!.day}-${manageCntrl.rentFrom.value!.month}-${manageCntrl.rentFrom.value!.year}',
                                            width: 158.w, onTap: () {
                                          manageCntrl
                                              .selectDateFrom(Get.context!);
                                        }),
                                      ],
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EditProfileWidget.commomText(
                                            'To (Rent)'),
                                        ManagementWidgets().datePickerContainer(
                                            manageCntrl.rentTo.value == null
                                                ? 'Select'
                                                : '${manageCntrl.rentTo.value!.day}-${manageCntrl.rentTo.value!.month}-${manageCntrl.rentTo.value!.year}',
                                            width: 158.w, onTap: () {
                                          manageCntrl
                                              .selectDateTo(Get.context!);
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                                // PersonlInfoWidget.commomText('Rent (Rs)'),
                                // Obx(() => customTextField(
                                //       keyboardType: TextInputType.number,
                                //       controller: manageCntrl.amountCntrl.value,
                                //       inputFormatters: [
                                //         FilteringTextInputFormatter.digitsOnly
                                //       ],
                                //       readOnly:
                                //           manageCntrl.isRentNegiosate.value,
                                //       width: Get.width / 2.3,
                                //       hintText: 'Type Here...',
                                //       isBorder: true,
                                //       isFilled: false,
                                //     )),
                                SizedBox(height: 5.h),
                                PersonlInfoWidget.commomText('Remarks'),
                                customTextField(
                                  controller: manageCntrl.remarkCntrl.value,
                                  hintText: 'Type Here...',
                                  isBorder: true,
                                  color: HexColor('#FFFFFF'),
                                  isFilled: false,
                                ),
                                SizedBox(height: 5.h),
                                if (manageCntrl.amenitiesList.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PersonlInfoWidget.commomText(
                                        'Amenities',
                                      ),
                                      Divider(
                                        color: HexColor('#EBEBEB'),
                                        height: 1.h,
                                      ),
                                      ManagementWidgets().amenitiesList(),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      SizedBox(height: 8.h),
                                    ],
                                  ),
                                Obx(() => manageCntrl.addTenantLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : customButton(
                                        onPressed: () {
                                          manageCntrl.onSubmitTapFromChoose();
                                        },
                                        text: 'Submit',
                                        height: 45.h,
                                        width: Get.width,
                                      )),
                              ],
                            )
                          : const SizedBox()
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  Widget buildDropdown<T>(
    T? selectedItem,
    List<T> items,
    String hintText,
    ValueChanged<T?> onChanged,
  ) {
    return Container(
      height: 44.h,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEBEBEB), width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: DropdownButton<T>(
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          underline: Container(),
          value: selectedItem,
          hint: Text(hintText),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                (item is Property)
                    ? item.title
                    : (item is Building)
                        ? item.name
                        : (item is Floor)
                            ? item.name
                            : (item is Unit)
                                ? item.name
                                : item.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
