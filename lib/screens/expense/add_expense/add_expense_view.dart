import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_controller.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_modal.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_widget.dart';
import '../../../common/text_styles.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final addExpCntrl = Get.put(AddExpenseController());

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
        title: Text(
            addExpCntrl.isfromEdit.value ? 'Update Expense' : 'Add Expense',
            style: CustomStyles.otpStyle050505W700S16),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Property', isMandatory: true),
                  Obx(() => buildDropdown<Property>(
                        addExpCntrl.selectedProperty.value,
                        addExpCntrl.projrctsList,
                        'Select Property',
                        (value) => addExpCntrl.onProjectSelected(value),
                      )),
                  SizedBox(height: 5.h),
                  PersonlInfoWidget.commomText('Building', isMandatory: true),
                  Obx(() => buildDropdown<Building>(
                        addExpCntrl.selectedBuilding.value,
                        addExpCntrl.selectedProperty.value?.buildings ?? [],
                        'Select Building',
                        (value) => addExpCntrl.onBuildingSelected(value),
                      )),
                  // PersonlInfoWidget.commomText('Project',isMandatory: true),
                  // bigDropDown(selectedItem: addExpCntrl.selectedProjectItem.value, items: addExpCntrl.projrctsList.value, onChange: (item){
                  //   addExpCntrl.selectedProjectItem.value=item;
                  // }),
                  // SizedBox(height: 5.h,),
                  // PersonlInfoWidget.commomText('Building',isMandatory: true),
                  // bigDropDown(selectedItem: addExpCntrl.selectedBuildingItem.value, items: addExpCntrl.buildingList.value, onChange: (item){
                  //   addExpCntrl.selectedBuildingItem.value=item;
                  // }),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Expense Type',
                      isMandatory: true),
                  bigDropDown(
                      selectedItem: addExpCntrl.selectedExpenseItem.value,
                      items: addExpCntrl.expenseList,
                      onChange: (item) {
                        addExpCntrl.selectedExpenseItem.value = item;
                      }),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Date', isMandatory: true),
                  AddExpenseWidgets().datePickerContainer(),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Amount', isMandatory: true),
                  customTextField(
                      controller: addExpCntrl.amountCntrl.value,
                      focusNode: addExpCntrl.amountFocus.value,
                      keyboardType: TextInputType.number,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#FFFFFF'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Remarks'),
                  customTextField(
                      controller: addExpCntrl.remarkCntrl.value,
                      focusNode: addExpCntrl.remarkFocus.value,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#FFFFFF'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Payment Type',
                      isMandatory: true),
                  SizedBox(
                    height: 2.h,
                  ),
                  AddExpenseWidgets().radioButtons(),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Attach'),
                  AddExpenseWidgets().filePickerContainer(),
                  SizedBox(
                    height: 5.h,
                  ),
                  addExpCntrl.addExpenseDatta.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : customButton(
                          onPressed: () {
                            addExpCntrl.onSaveTap();
                          },
                          text:
                              addExpCntrl.isfromEdit.value ? 'Update' : 'Save',
                          width: Get.width),
                  SizedBox(
                    height: 5.h,
                  ),
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
