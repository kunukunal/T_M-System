import 'package:flutter/material.dart';
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
                  ? 'Payment Request'
                  : paymntCntrl.isPaymentRequest.value == 2
                      ? 'Payment Request'
                      : 'Payment Request Success',
              style: CustomStyles.titleText
                  .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
            ),
            centerTitle: true,
          ),
          body: Padding(
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
                        customBorderButton("Send Request", () {
                          paymntCntrl.ontapSendRequest();
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
                              Text("Pay Your Rent Via",
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
                                        paymntCntrl.payentModeChoose.value = 2;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: paymntCntrl.payentModeChoose
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
                                            Text("Cash",
                                                style: TextStyle(
                                                    color: paymntCntrl
                                                                .payentModeChoose
                                                                .value ==
                                                            2
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize:
                                                        16.sp - commonFontSize,
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
                                        paymntCntrl.payentModeChoose.value = 1;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: paymntCntrl.payentModeChoose
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
                                            Text("Online Payments",
                                                style: TextStyle(
                                                    color: paymntCntrl
                                                                .payentModeChoose
                                                                .value ==
                                                            1
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize:
                                                        16.sp - commonFontSize,
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
                          customBorderButton("Request", () {
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
                                controller: paymntCntrl.ammountController.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.h,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: lightBorderGrey),
                                  ),
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
                                  : customBorderButton("Request", () {
                                      paymntCntrl.ontapRequest();
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
                                  Text("We're on it!",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20.sp - commonFontSize,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5.h),
                                  Text(
                                      "Your payment request has been send and you’ll get notification for your Confirmation.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 14.sp - commonFontSize,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 5.h),
                                  customBorderButton("Go Back Home", () {
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
          ));
    });
  }
}
