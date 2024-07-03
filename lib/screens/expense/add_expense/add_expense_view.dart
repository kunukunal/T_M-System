
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_controller.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_widget.dart';
import '../../../common/text_styles.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';

class AddExpenseScreen extends StatelessWidget {
   AddExpenseScreen({super.key});

   final addExpCntrl = Get.put(AddExpenseController());

  @override
  Widget build(BuildContext context) {
      return SafeArea(child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: ()=>Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: backArrowImage,
            ),
          ),
          title: Text('Add Expense', style: CustomStyles.otpStyle050505W700S16),

        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Divider(color:HexColor('#EBEBEB'),height: 1.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                 () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Project',isMandatory: true),
                      bigDropDown(selectedItem: addExpCntrl.selectedProjectItem.value, items: addExpCntrl.projrctsList.value, onChange: (item){
                        addExpCntrl.selectedProjectItem.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Building',isMandatory: true),
                      bigDropDown(selectedItem: addExpCntrl.selectedBuildingItem.value, items: addExpCntrl.buildingList.value, onChange: (item){
                        addExpCntrl.selectedBuildingItem.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Expense Type',isMandatory: true),
                      bigDropDown(selectedItem: addExpCntrl.selectedExpenseItem.value, items: addExpCntrl.expenseList.value, onChange: (item){
                        addExpCntrl.selectedExpenseItem.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Date',isMandatory: true),
                      AddExpenseWidgets().datePickerContainer(),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Amount',isMandatory: true),
                      customTextField(
                          controller: addExpCntrl.amountCntrl.value,
                          focusNode: addExpCntrl.amountFocus.value,
                          hintText: 'Type Here...',
                          isBorder: true,
                          color: HexColor('#FFFFFF'),
                          isFilled: false),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Remarks'),
                      customTextField(
                          controller: addExpCntrl.remarkCntrl.value,
                          focusNode: addExpCntrl.remarkFocus.value,
                          hintText: 'Type Here...',
                          isBorder: true,
                          color: HexColor('#FFFFFF'),
                          isFilled: false),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Payment Type',isMandatory: true),
                      SizedBox(height: 2.h,),
                      AddExpenseWidgets().radioButtons(),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Attach'),
                      AddExpenseWidgets().filePickerContainer(),
                      SizedBox(height: 5.h,),
                      customButton(onPressed: (){
                        addExpCntrl.onSaveTap();
                      },text: 'Save',width: Get.width)

                    ],
                  );
                }
              ),
            )


          ],
        ),
      ));
  }
}
