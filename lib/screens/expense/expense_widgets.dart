import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/expense/expense_controller.dart';

class ExpenseWidgets {
  dateRangePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('21 Jan 2024 - 24 Feb 2024',
            style: CustomStyles.otpStyle050505
                .copyWith(fontSize: 16.sp, fontFamily: 'DM Sans')),
        SizedBox(
          width: 10.w,
        ),
        dropDownArrowIcon,
      ],
    );
  }

  totalExpenseContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Container(
        // height: 134.h,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₹1,550.00',
                style: CustomStyles.black16
                    .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                'Total Expense this month',
                style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Container(
              //   decoration:
              //       BoxDecoration(borderRadius: BorderRadius.circular(6.r)),
              //   child: LinearProgressIndicator(
              //     backgroundColor: HexColor('#D9D9D9'),
              //     color: HexColor('#FA4343'),
              //     value: 0.5,
              //     minHeight: 8.0,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  expenseList() {
    final expenseCntrl = Get.find<ExpenseController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: CustomStyles.otpStyle050505
              .copyWith(fontFamily: 'DM Sans', fontWeight: FontWeight.w700),
        ),
        Obx(() {
          return expenseCntrl.isExpenseDataget.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : expenseCntrl.expenseList.isEmpty
                  ? const Center(
                      child: Text("No Expense data found"),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: expenseCntrl.expenseList.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                            expenseCntrl.expenseList[index]['expense_date']);
                        String formattedDate =
                            DateFormat('dd MMM').format(dateTime);
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: HexColor('#EBEBEB'))),
                            child: Padding(
                              padding: EdgeInsets.all(15.r),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            color: HexColor('#BCD1F3'),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Center(
                                          child: Text(
                                            formattedDate,
                                            textAlign: TextAlign.center,
                                            style:
                                                CustomStyles.black16.copyWith(
                                              fontSize: 14.sp,
                                            ),
                                          ),
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
                                            Text(
                                              expenseCntrl.expenseList[index]
                                                  ['expense_type'],
                                              textAlign: TextAlign.center,
                                              style:
                                                  CustomStyles.black16.copyWith(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.w,
                                            ),
                                            Container(
                                              height: 22.h,
                                              width: expenseCntrl.expenseList[
                                                              index]
                                                          ['payment_type'] ==
                                                      'Cash'
                                                  ? 59.w
                                                  : 97.w,
                                              decoration: BoxDecoration(
                                                  color: expenseCntrl.expenseList[
                                                                  index][
                                                              'payment_type'] ==
                                                          'Cash'
                                                      ? HexColor('#00AA50')
                                                      : HexColor('#ED893E'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child: Center(
                                                child: Text(
                                                  expenseCntrl
                                                          .expenseList[index]
                                                      ['payment_type'],
                                                  textAlign: TextAlign.center,
                                                  style: CustomStyles.white12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.w,
                                            ),
                                            Text(
                                              expenseCntrl.expenseList[index]
                                                  ['remarks'],
                                              style: CustomStyles.desc606060
                                                  .copyWith(
                                                      fontSize: 12.sp,
                                                      fontFamily: 'DM Sans'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "₹${expenseCntrl.expenseList[index]['expense_amount']}",
                                        style: CustomStyles.amountFA4343W500S15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    color: HexColor('#EBEBEB'),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          expenseCntrl
                                                  .expenseList[index]['images']
                                                  .isNotEmpty
                                              ? expenseCntrl.expenseList[index]
                                                      ['images'][0]['image_url']
                                                  .toString()
                                                  .split('/')
                                                  .last
                                              : "No Image",
                                          style: CustomStyles
                                              .otpStyle050505W400S14,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            expenseCntrl
                                                    .expenseList[index]
                                                        ['images']
                                                    .isNotEmpty
                                                ? showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    enableDrag: false,
                                                    useSafeArea: true,
                                                    builder: (context) {
                                                      return SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Text(
                                                                    "Expense Image",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .cancel),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              Wrap(
                                                                children: [
                                                                  ...List.generate(
                                                                      expenseCntrl
                                                                          .expenseList[
                                                                              index]
                                                                              [
                                                                              'images']
                                                                          .length,
                                                                      (ind) {
                                                                    return Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              300,
                                                                          child:
                                                                              Image.network(
                                                                            expenseCntrl.expenseList[index]['images'][ind]['image_url'],
                                                                          ),
                                                                        ),
                                                                        const Divider()
                                                                      ],
                                                                    );
                                                                  })
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : customSnackBar(
                                                    context, "No Image found");
                                          },
                                          child: eyeIcon),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            expenseCntrl.onEditTap(expenseCntrl
                                                .expenseList[index]);
                                          },
                                          child: pencilIcon),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            deleteExpense(
                                                button1: "No",
                                                button2: "Yes",
                                                onButton1Tap: () {
                                                  Get.back();
                                                },
                                                onButton2Tap: () {
                                                  Get.back();
                                                  expenseCntrl.onDeleteTap(
                                                      expenseCntrl.expenseList[
                                                          index]['id']);
                                                },
                                                title:
                                                    "Are you sure you want to delete the Expense?");
                                          },
                                          child: dustbinIcon)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
        }),
      ],
    );
  }

  deleteExpense({
    required String title,
    required String button1,
    required String button2,
    required Function() onButton1Tap,
    required Function() onButton2Tap,
  }) async {
    return await Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(button1, onButton1Tap,
                              verticalPadding: 5.h,
                              horizontalPadding: 2.w,
                              btnHeight: 35.h,
                              width: 140.w,
                              borderColor: HexColor('#679BF1'),
                              textColor: HexColor('#679BF1')),
                          customBorderButton(
                            button2,
                            onButton2Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
