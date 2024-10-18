import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/expense/expense_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class ExpenseWidgets {
  dateRangePicker() {
    final expense = Get.find<ExpenseController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            expense.selectMonthYear(Get.context!, true);
          },
          child: Card(
            surfaceTintColor: Colors.transparent,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Obx(() {
                    return Text(
                        "${expense.expnseStartFrom.value?.day}-${expense.expnseStartFrom.value?.month}-${expense.expnseStartFrom.value?.year}",
                        style: CustomStyles.otpStyle050505.copyWith(
                            fontSize: 16.sp - commonFontSize,
                            fontFamily: 'DM Sans'));
                  }),
                  SizedBox(
                    width: 2.w,
                  ),
                  dropDownArrowIcon,
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        GestureDetector(
          onTap: () {
            expense.selectMonthYear(Get.context!, false);
          },
          child: Card(
            surfaceTintColor: Colors.transparent,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    return Text(
                        "${expense.expnseEndFrom.value?.day}-${expense.expnseEndFrom.value?.month}-${expense.expnseEndFrom.value?.year}",
                        style: CustomStyles.otpStyle050505.copyWith(
                            fontSize: 16.sp - commonFontSize,
                            fontFamily: 'DM Sans'));
                  }),
                  SizedBox(
                    width: 2.w,
                  ),
                  dropDownArrowIcon,
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
        GestureDetector(
            onTap: () {
              expense.searchByDates();
            },
            child: searchIcon)
      ],
    );
  }

  totalExpenseContainer() {
    final cntrl = Get.find<ExpenseController>();
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
              Obx(() {
                return Text(
                  '₹${cntrl.istotalExpense.value}',
                  style: CustomStyles.black16.copyWith(
                      fontSize: 28.sp - commonFontSize,
                      fontWeight: FontWeight.w700),
                );
              }),
              Text(
                'total_expense_this_month'.tr,
                style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans', fontSize: 14),
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
          'history'.tr,
          style: CustomStyles.otpStyle050505
              .copyWith(fontFamily: 'DM Sans', fontWeight: FontWeight.w700),
        ),
        Obx(() {
          return expenseCntrl.isExpenseDataget.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : expenseCntrl.expenseList.isEmpty
                  ? Center(
                      child: Text("no_expense_data_found".tr),
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
                                              fontSize: 14.sp - commonFontSize,
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
                                                fontSize:
                                                    15.sp - commonFontSize,
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
                                                      fontSize: 12.sp -
                                                          commonFontSize,
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
                                              : "no_image".tr,
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
                                                                  Text(
                                                                    "expense_image"
                                                                        .tr,
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
                                                                        ElevatedButton.icon(
                                                                            icon: const Icon(
                                                                              Icons.download,
                                                                              color: Colors.white,
                                                                            ),
                                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                                                            onPressed: () async {
                                                                              await DioClientServices.instance.saveImageToGallery(expenseCntrl.expenseList[index]['images'][ind]['image_url']).then((value) {
                                                                                if (value['isSuccess'] == true) {
                                                                                  customSnackBar(Get.context!, "document_download_successfully".tr);
                                                                                }
                                                                              });
                                                                            },
                                                                            label: Text(
                                                                              "download".tr,
                                                                              style: TextStyle(color: Colors.white),
                                                                            )),
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
                                                : customSnackBar(context,
                                                    "no_image_found".tr);
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
                                                button1: "no".tr,
                                                button2: "yes".tr,
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
                                                    "are_you_sure_delete_expense"
                                                        .tr);
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
                                fontSize: 18.sp - commonFontSize,
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
