
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/expense/expense_controller.dart';

class ExpenseWidgets{
  
  
  dateRangePicker(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('21 Jan 2024 - 24 Feb 2024', style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp, fontFamily: 'DM Sans')),
        SizedBox(width: 10.w,),
        dropDownArrowIcon,

      ],
    );
  }

  totalExpenseContainer(){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 15.h),
      child: Container(
        height: 134.h,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: HexColor('#EBEBEB'))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('₹1,550.00',style: CustomStyles.black16.copyWith(fontSize: 28.sp,fontWeight: FontWeight.w700),),
              Text('Total Expense this month',style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),),
              SizedBox(height: 10.h,),
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(6.r)
                 ),
                 child: LinearProgressIndicator(
                  backgroundColor: HexColor('#D9D9D9'),
                 color: HexColor('#FA4343'),
                 
                 value: 0.5,
                  minHeight: 8.0,
                               ),
               ),

            ],
          ),
        ),
      ),
    );
  }

  expenseList(){
    final expenseCntrl = Get.find<ExpenseController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('History',style: CustomStyles.otpStyle050505.copyWith(fontFamily: 'DM Sans', fontWeight: FontWeight.w700),),
        Obx(
           () {
            return ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: expenseCntrl.expenseList.length,
                itemBuilder: (context, index){
              return Padding(
                padding:  EdgeInsets.symmetric(vertical: 7.h),
                child: Container(
                  height: 156.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: HexColor('#EBEBEB'))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: HexColor('#BCD1F3'),
                                borderRadius: BorderRadius.circular(10.r)
                              ),
                              child: Center(
                                child: Text(
                                  expenseCntrl.expenseList[index]['date'],
                                  textAlign: TextAlign.center,
                                  style: CustomStyles.black16.copyWith(fontSize: 14.sp,),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    expenseCntrl.expenseList[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: CustomStyles.black16.copyWith(fontSize: 15.sp,),
                                  ),
                                  SizedBox(height: 5.w,),
                                  Container(
                                    height: 22.h,
                                    width: expenseCntrl.expenseList[index]['type']=='Cash'?59.w:97.w,
                                    decoration: BoxDecoration(
                                        color:expenseCntrl.expenseList[index]['type']=='Cash'?HexColor('#00AA50'): HexColor('#ED893E'),
                                        borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    child: Center(
                                      child: Text(
                                        expenseCntrl.expenseList[index]['type'],
                                        textAlign: TextAlign.center,
                                        style: CustomStyles.white12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.w,),

                                  Text(
                                      expenseCntrl.expenseList[index]['description'],
                                    style: CustomStyles.desc606060.copyWith(fontSize: 12.sp,fontFamily: 'DM Sans'),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              expenseCntrl.expenseList[index]['amount'],
                              style: CustomStyles.amountFA4343W500S15,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Divider(
                          color: HexColor('#EBEBEB'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                expenseCntrl.expenseList[index]['fileName'],
                                style: CustomStyles.otpStyle050505W400S14,
                              ),
                            ),
                            eyeIcon,
                            SizedBox(width: 10.w,),
                            pencilIcon,
                            SizedBox(width: 10.w,),

                            dustbinIcon
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        ),
      ],
    );
  }
}