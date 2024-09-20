import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_controller.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_widget.dart';

class PaymentRequestScreen extends StatelessWidget {
  PaymentRequestScreen({
    super.key,
  });
  final paymntCntrl = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              paymntCntrl.isPaymentRequest.value == 0 ||
                      paymntCntrl.isPaymentRequest.value == 1
                  ? 'payment_request'.tr
                  : paymntCntrl.isPaymentRequest.value == 2
                      ? 'payment_request'.tr
                      : 'payment_request_status'.tr,
              style: CustomStyles.titleText
                  .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
            ),
            centerTitle: true,
          ),
          body: WillPopScope(
            onWillPop: () async {
              Get.back(result: paymntCntrl.needReload.value);
              return false;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: paymntCntrl.isPaymentRequest.value == 0
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PaymentWidget().paymentContainer(),
                          SizedBox(height: 5.h),
                          PaymentWidget().paymenRequestForm(),
                          SizedBox(height: 5.h),
                          customBorderButton("Continue", () {
                            String amnt =
                                paymntCntrl.ammountController.value.text;
                            if (paymntCntrl
                                    .ammountController.value.text.isNotEmpty &&
                                double.parse(amnt) > 0.0) {
                              double amount =
                                  ((paymntCntrl.totalduetillnow.value +
                                          paymntCntrl.pendingthismonth.value) -
                                      paymntCntrl.pendingprocessamount.value);
                              if (amount >=
                                  double.parse(paymntCntrl
                                      .ammountController.value.text)) {
                                paymntCntrl.ontapSendRequest();
                              } else {
                                customSnackBar(context,
                                    "Please enter the valid ammount. amount is less than or equal $amount");
                              }
                            } else {
                              customSnackBar(
                                  context, "Please enter the valid ammount");
                            }
                          },
                              fontweight: FontWeight.w500,
                              verticalPadding: 5.h,
                              horizontalPadding: 2.w,
                              btnHeight: 40.h,
                              color: HexColor('#679BF1'),
                              textColor: HexColor('#FFFFFF'),
                              borderColor: Colors.transparent),
                        ],
                      ),
                    )
                  : paymntCntrl.isPaymentRequest.value == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("pay_your_rent_via".tr,
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 20.sp - commonFontSize,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          paymntCntrl.payentModeChoose.value =
                                              2;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: paymntCntrl
                                                          .payentModeChoose
                                                          .value ==
                                                      2
                                                  ? HexColor("#679BF1")
                                                  : null,
                                              border: Border.all(
                                                  color: HexColor("#E5E7EB")),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25, horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/cash_pay.svg",
                                                color: paymntCntrl
                                                            .payentModeChoose
                                                            .value ==
                                                        2
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text("cash".tr,
                                                  style: TextStyle(
                                                      color: paymntCntrl
                                                                  .payentModeChoose
                                                                  .value ==
                                                              2
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 16.sp -
                                                          commonFontSize,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          paymntCntrl.payentModeChoose.value =
                                              1;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: paymntCntrl
                                                          .payentModeChoose
                                                          .value ==
                                                      1
                                                  ? HexColor("#679BF1")
                                                  : null,
                                              border: Border.all(
                                                  color: HexColor("#E5E7EB")),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25, horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/online_pay.svg",
                                                color: paymntCntrl
                                                            .payentModeChoose
                                                            .value ==
                                                        1
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text("online_payments".tr,
                                                  style: TextStyle(
                                                      color: paymntCntrl
                                                                  .payentModeChoose
                                                                  .value ==
                                                              1
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 16.sp -
                                                          commonFontSize,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            customBorderButton("Continue", () {
                              paymntCntrl.ontappaymentVia();
                            },
                                fontweight: FontWeight.w500,
                                verticalPadding: 5.h,
                                horizontalPadding: 2.w,
                                btnHeight: 40.h,
                                color: HexColor('#679BF1'),
                                textColor: HexColor('#FFFFFF'),
                                borderColor: Colors.transparent),
                          ],
                        )
                      : paymntCntrl.isPaymentRequest.value == 2
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PaymentWidget().unitContainer(),
                                TextFormField(
                                  controller:
                                      paymntCntrl.ammountController.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.h,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "0.00",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: lightBorderGrey),
                                    ),
                                    prefixText: "₹",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: lightBorderGrey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: lightBorderGrey),
                                    ),
                                  ),
                                ),
                                paymntCntrl.isPaymentRequestSucess.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : customBorderButton("send_request".tr, () {
                                        String amnt = paymntCntrl
                                            .ammountController.value.text;
                                        if (paymntCntrl.ammountController.value
                                                .text.isNotEmpty &&
                                            double.parse(amnt) > 0.0) {
                                          double amount = ((paymntCntrl
                                                      .totalduetillnow.value +
                                                  paymntCntrl
                                                      .pendingthismonth.value) -
                                              paymntCntrl
                                                  .pendingprocessamount.value);
                                          if (amount >=
                                              double.parse(paymntCntrl
                                                  .ammountController
                                                  .value
                                                  .text)) {
                                            paymntCntrl.ontapRequest();
                                          } else {
                                            customSnackBar(context,
                                                "Please enter the valid ammount. amount is less than or equal $amount");
                                          }
                                        } else {
                                          customSnackBar(context,
                                              "Please enter the valid ammount");
                                        }
                                      },
                                        fontweight: FontWeight.w500,
                                        verticalPadding: 5.h,
                                        horizontalPadding: 2.w,
                                        btnHeight: 40.h,
                                        color: HexColor('#679BF1'),
                                        textColor: HexColor('#FFFFFF'),
                                        borderColor: Colors.transparent),
                              ],
                            )
                          : paymntCntrl.isPaymentRequest.value == 3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/payment_checked_img.png",
                                      height: 100,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text("we_are_on_it".tr,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 20.sp - commonFontSize,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5.h),
                                    Text("your_payment_request_sent".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 14.sp - commonFontSize,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 5.h),
                                    customBorderButton("go_back_home".tr, () {
                                      paymntCntrl.ontapbackHomeRequest();
                                    },
                                        fontweight: FontWeight.w500,
                                        verticalPadding: 5.h,
                                        horizontalPadding: 2.w,
                                        btnHeight: 40.h,
                                        color: HexColor('#679BF1'),
                                        textColor: HexColor('#FFFFFF'),
                                        borderColor: Colors.transparent),
                                  ],
                                )
                              : paymntCntrl.isPaymentRequest.value == 4
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/cross_icon.png",
                                          height: 100,
                                          color: Colors.red,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text("transaction_failed".tr,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize:
                                                    20.sp - commonFontSize,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5.h),
                                        Text("payment_request_failed".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: black,
                                                fontSize:
                                                    14.sp - commonFontSize,
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(height: 5.h),
                                        customBorderButton("go_back_home".tr,
                                            () {
                                          paymntCntrl.ontapbackHomeRequest();
                                        },
                                            fontweight: FontWeight.w500,
                                            verticalPadding: 5.h,
                                            horizontalPadding: 2.w,
                                            btnHeight: 40.h,
                                            color: HexColor('#679BF1'),
                                            textColor: HexColor('#FFFFFF'),
                                            borderColor: Colors.transparent),
                                      ],
                                    )
                                  : const SizedBox(),
            ),
          ));
    });
  }
}
